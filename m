Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129903AbQKWXSQ>; Thu, 23 Nov 2000 18:18:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129698AbQKWXSG>; Thu, 23 Nov 2000 18:18:06 -0500
Received: from [194.213.32.137] ([194.213.32.137]:13572 "EHLO bug.ucw.cz")
        by vger.kernel.org with ESMTP id <S129903AbQKWXR6>;
        Thu, 23 Nov 2000 18:17:58 -0500
Message-ID: <20001123223155.A5789@bug.ucw.cz>
Date: Thu, 23 Nov 2000 22:31:55 +0100
From: Pavel Machek <pavel@suse.cz>
To: kernel list <linux-kernel@vger.kernel.org>
Subject: Do you remember that oops which printed %lx instead of values?
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

It happened to me today while debugging x86-64. That code probably
likes to fail this way ;-).
								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
