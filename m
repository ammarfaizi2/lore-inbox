Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132933AbRAHVfx>; Mon, 8 Jan 2001 16:35:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132702AbRAHVfe>; Mon, 8 Jan 2001 16:35:34 -0500
Received: from [194.213.32.137] ([194.213.32.137]:16132 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S132266AbRAHVfX>;
	Mon, 8 Jan 2001 16:35:23 -0500
Message-ID: <20010108223435.A1661@bug.ucw.cz>
Date: Mon, 8 Jan 2001 22:34:35 +0100
From: Pavel Machek <pavel@suse.cz>
To: torvalds@transmeta.com, kernel list <linux-kernel@vger.kernel.org>
Subject: prerelease-to-final braindamage
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Very clever. Invent new naming scheme of patches every couple of
weeks, so that as many people as possible damage their trees.

All other patches are called patch-VERSION. This one has to be called
prerelease-to-final. And applying it over test12 if you missed the
fact -prerelease exists (like I did) has some pretty fatal
effect. Why can't you stick with 3 version numbers, Linus?
								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
