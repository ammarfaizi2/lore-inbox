Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129103AbQKFVQ5>; Mon, 6 Nov 2000 16:16:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129454AbQKFVQr>; Mon, 6 Nov 2000 16:16:47 -0500
Received: from [194.213.32.137] ([194.213.32.137]:260 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S129103AbQKFVQk>;
	Mon, 6 Nov 2000 16:16:40 -0500
Message-ID: <20001106103539.A343@bug.ucw.cz>
Date: Mon, 6 Nov 2000 10:35:39 +0100
From: Pavel Machek <pavel@suse.cz>
To: kernel list <linux-kernel@vger.kernel.org>
Subject: mount -tcoda /dev/cfs0 /mnt no longer works in -test9 and newer?
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

It complains

coda_read_super: Bad mount data
coda_read_super: device index: 0

and will not mount. What do I need to mount coda?
								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
