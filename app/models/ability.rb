class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, [Post, Comment, Like]

    return unless user.present?

    can :show, User, id: user.id
    can :add_image, User, id: user.id
    can :create, [Comment, Like]

    can(:destroy, Comment, user:)
    can(:destroy, Like, user:)

    return unless user.admin?

    can :manage, :all
  end
end
