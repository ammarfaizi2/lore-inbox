Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272163AbRH3LdH>; Thu, 30 Aug 2001 07:33:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272166AbRH3Lc5>; Thu, 30 Aug 2001 07:32:57 -0400
Received: from [194.213.32.137] ([194.213.32.137]:35332 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S272163AbRH3Lco>;
	Thu, 30 Aug 2001 07:32:44 -0400
Date: Sun, 26 Aug 2001 13:08:59 +0000
From: Pavel Machek <pavel@ucw.cz>
To: linux-kernel@vger.kernel.org
Subject: Reiserfs: how to mount without journal replay?
Message-ID: <20010826130858.A39@toy.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

For recovering broken machine, I'd like to mount without replaying journal.
[reiserfs panics while replaying journal; seems there are still some bugs
hidden in there]. Unfortunately, "nolog" option does not seem imlemented.
Are there experimental to do that?
								Pavel
PS: Please CC me.
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

