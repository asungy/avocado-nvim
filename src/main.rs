use neovim_lib::{Session, Neovim, NeovimApi};

fn main() {
    // Start in Neovim via `:echo serverstart("127.0.0.1:9000")`
    let mut session = Session::new_tcp("127.0.0.1:9000").unwrap();
    session.start_event_loop();
    let mut nvim = Neovim::new(session);

    let buffers = nvim.list_bufs().unwrap();
    buffers[0].set_lines(&mut nvim, 0, 0, true, vec!["Hello Neovim".into()]).unwrap();
}
