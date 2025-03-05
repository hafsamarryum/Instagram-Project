# class PostPolicy < ApplicationPolicy
#   # Only admin can delete posts
#   def destroy?
#     user.admin?
#   end

#   # Everyone can read posts
#   def show?
#     true
#   end
#   # Everyone can create posts, but we could restrict this if needed
#   def create?
#     user.present? # Allow authenticated users to create posts
#   end

#   # Admin can edit any post
#   def update?
#     user.admin? || record.user == user
#   end

#   class Scope < ApplicationPolicy::Scope
#     # NOTE: Be explicit about which records you allow access to!
#     # def resolve
#     #   scope.all
#     # end
#   end
# end
