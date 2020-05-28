module StaticPagesHelper
  def event_type_options
    [
      'CommitCommentEvent',
      'CreateEvent',
      'DeleteEvent',
      'ForkEvent',
      'GollumEvent',
      'IssueCommentEvent',
      'IssuesEvent',
      'MemberEvent',
      'PublicEvent',
      'PullRequestEvent',
      'PullRequestReviewCommentEvent',
      'PushEvent',
      'ReleaseEvent',
      'SponsorshipEvent',
      'WatchEvent'
    ]
  end
end
