Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129645AbQKBWGW>; Thu, 2 Nov 2000 17:06:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129726AbQKBWGM>; Thu, 2 Nov 2000 17:06:12 -0500
Received: from [194.213.32.137] ([194.213.32.137]:2308 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S129645AbQKBWF7>;
	Thu, 2 Nov 2000 17:05:59 -0500
Message-ID: <20001102004944.A188@bug.ucw.cz>
Date: Thu, 2 Nov 2000 00:49:44 +0100
From: Pavel Machek <pavel@suse.cz>
To: kernel list <linux-kernel@vger.kernel.org>
Subject: Are there known problems with egcs-2.90.29 980515 (egcs-1.0.3 release)?
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I see that gcc-2.7.2 is unusable for compiling kernel, because of
named initializers problems.

What is status of egcs-2.90.29 980515 (egcs-1.0.3 release)? Are there
known bugs preventing it from compiling kernel?
								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
