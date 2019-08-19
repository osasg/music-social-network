//= require cable
//= require_self
//= require_tree .

this.App = {};
App.streams = {};

App.cable = ActionCable.createConsumer();

App.register_like_stream = post => {
  App.streams[`like_stream_${post.id}`] = App.cable.subscriptions.create({
    channel: 'MusicSocialNetwork::LikeChannel',
    stream: 'likes',
    likeable_id: post.id
  }, {  
    received({ user_id, post_id }) {
      const count = document.querySelector(`.likeable-count-${post.id}`);
      const form = document.querySelector(`.likeable-form-${post.id}`);
      const btn = document.querySelector(`.likeable-btn-${post.id}`);

      const form_action_url = new URL(form.action);

      count.textContent = parseInt(count.textContent) + 1;

      if (current_user_id != user_id)
        return;

      form.action = `/unlike${form_action_url.search}`;
      btn.classList.remove('btn-success');
      btn.classList.add('btn-info');
      btn.textContent = 'Unlike';
    }
  });
}

App.register_unlike_stream = post => {
  App.streams[`unlike_stream_${post.id}`] = App.cable.subscriptions.create({
    channel: 'MusicSocialNetwork::LikeChannel',
    stream: 'unlikes',
    likeable_id: post.id
  }, {  
    received({ user_id, post_id }) {
      const count = document.querySelector(`.likeable-count-${post.id}`);
      const form = document.querySelector(`.likeable-form-${post.id}`);
      const btn = document.querySelector(`.likeable-btn-${post.id}`);

      const form_action_url = new URL(form.action);

      count.textContent = parseInt(count.textContent) - 1;

      if (current_user_id != user_id)
        return;

      form.action = `/like${form_action_url.search}`;
      btn.classList.remove('btn-info');
      btn.classList.add('btn-success');
      btn.textContent = 'Like';
    }
  });
}
