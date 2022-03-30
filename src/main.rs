use tokio;

fn main() {
    let mut interval_timer = tokio::time::interval(chrono::Duration::days(1).to_std().unwrap());
    loop {
        // Wait for the next interval tick
        interval_timer.tick().await;
        tokio::spawn(async { do_my_task().await; }); // For async task
        tokio::task::spawn_blocking(|| do_my_task()); // For blocking task
    }
}
