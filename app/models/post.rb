class Post < ApplicationRecord
  include CableReady::Broadcaster

  belongs_to :user
  before_save { body.squeeze! }
  validates :body, presence: true, length: { maximum: 200 }

  # TODO Transfer code from Model to ActiveJob
  after_create do
    cable_ready['feed'].insert_adjacent_html(
      selector: '#pinned-post',
      position: 'afterend',
      html: ApplicationController.render(partial: 'posts/post', locals: { post: self, editable: false })
    )
    cable_ready.broadcast
  end

  after_destroy do
    cable_ready['feed'].remove(
      selector: '#post_' + id.to_s
    )
    cable_ready.broadcast
  end
end
