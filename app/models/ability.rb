# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, [Post]

    return unless user.present?

    if user.admin_role?
      can :manage, :all
      return
    end

    if user.user_role?
      can :manage, Post, user_id: user.id
    end
  end
end
