Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269777AbRHXEqe>; Fri, 24 Aug 2001 00:46:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270905AbRHXEqZ>; Fri, 24 Aug 2001 00:46:25 -0400
Received: from shaker.worfie.net ([203.8.161.33]:22034 "HELO mail.worfie.net")
	by vger.kernel.org with SMTP id <S269777AbRHXEqO>;
	Fri, 24 Aug 2001 00:46:14 -0400
Date: Fri, 24 Aug 2001 12:46:26 +0800 (WST)
From: "J.Brown (Ender/Amigo)" <ender@enderboi.com>
X-X-Sender: <ender@shaker.worfie.net>
To: <linux-kernel@vger.kernel.org>
Subject: From 2.2.19 to 2.4.8ac8 - serial console no longer works
Message-ID: <Pine.LNX.4.31.0108241240240.3903-100000@shaker.worfie.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey all.

Recently I've been PXE booting a lot of Linux boxen from a remote
location, and accessing them through a Perle CS9000 console server.

Under 2.2.19 I've had absolutely no probs, but I upgraded the image to
2.4.8 last night. It all appeared to work, except that nothing I TYPE
appears to hit the machine.

I suspect it's because the CS9000 is operating with no flow control.
But I've got no idea what's changed between 2.2.19 and 2.4.8 that could
affect it :)

Anyone have any ideas?

Regards,	| If I must have computer systems with publically
	 Ender  | available terminals, the maps they display of my complex
  (James Brown)	| will have a room clearly marked as the Main Control Room.
		| That room will be the Execution Chamber. The actual main
		| control room will be marked as Sewage Overflow Containment.

