module ApplicationHelper
  include Pagy::Frontend

  def avatar_or_initial(user, size: 50)
    return content_tag(:div, "?",
      class: "d-flex align-items-center justify-content-center rounded-circle bg-secondary text-white fw-bold me-2",
      style: "height: #{size}px; width: #{size}px; font-size: #{size / 2.5}px; text-transform: uppercase;"
    ) if user.nil? || user.name.blank?

    if user.avatar.attached?
    image_url = rails_blob_url(user.avatar, disposition: "attachment") + "?t=#{user.updated_at.to_i}"
    image_tag(image_url, style: "height: #{size}px; width: #{size}px; border-radius: 50%; object-fit: cover;")
    else
      content_tag(:div, user.name.first.upcase,
        class: "d-flex align-items-center justify-content-center rounded-circle bg-primary text-white fw-bold me-2",
        style: "height: #{size}px; width: #{size}px; font-size: #{size / 2.5}px; text-transform: uppercase;"
      )
    end
  end
end
