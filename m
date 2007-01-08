Return-Path: <linux-kernel-owner+w=401wt.eu-S1161220AbXAHKfL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161220AbXAHKfL (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 05:35:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161221AbXAHKfL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 05:35:11 -0500
Received: from mail.gmx.net ([213.165.64.20]:58592 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1161220AbXAHKfK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 05:35:10 -0500
X-Authenticated: #9872103
Message-ID: <45A22D69.3010905@gmx.net>
Date: Mon, 08 Jan 2007 12:39:21 +0100
From: Dirk <d_i_r_k_@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.2pre) Gecko/20070104 SeaMonkey/1.1
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Gaming Interface
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nice day, everyone!

How about having a simple Game API like SDL included in the Kernel and
officially announce the promise to change it only once every couple of
years?

I guess that will make it a lot easier for Game producers to calculate
the costs of porting things to Linux and people won't have to waste time
with win32 interfaces anymore that need more time to get working than it
would take to install win32 on a 2nd partition and run Linux from VMware
or something (After trying WoW, CS and others I know exactly what I'm
talking about).

I believe Game producers are pretty confused and need someone good
looking to talk to them on a presentation or so and tell them: "Here,
LOOK! A interface for Video, Sound, 3D and events in the kernel and it
will not change before 2.8.x. (Or for at least 5 years)."

I think that would help! Simple decision makers need such promises.

Linux Gamers can finally sit in the 1st row and leave all that 08/15
crap and waste of time behind.

That interface could should be (optional) compiled as module of course.
And it should put Audio, Video and Events _together_ in _one_ interface.
Pointing people at ALSA, Device Drivers, etc doesn't work since those
are 2+ interfaces instead of one and people will lean back and be like:
"Uhhhh... if they had all that in only one interface..."

It would also be a correct place to nclude the binary only drivers from
nVIDIA and ATI somehow, since only gaming folks really need those.


I know I'm wrong but the currect solutions suck so much... they made me
subscribe here,
Dirk
