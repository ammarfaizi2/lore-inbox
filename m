Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269494AbTCDOVK>; Tue, 4 Mar 2003 09:21:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269493AbTCDOVK>; Tue, 4 Mar 2003 09:21:10 -0500
Received: from zork.zork.net ([66.92.188.166]:9625 "EHLO zork.zork.net")
	by vger.kernel.org with ESMTP id <S269492AbTCDOVI>;
	Tue, 4 Mar 2003 09:21:08 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: xmms (audio) skipping in 2.5 (not 2.4)
From: Sean Neakums <sneakums@zork.net>
X-Worst-Pick-Up-Line-Ever: "Hey baby, wanna peer with my leafnode instance?"
X-Message-Flag: Message text advisory: IMPROPER FORETHOUGHT, MISMATCHED
 PARENTHESES
X-Mailer: Norman
X-Groin-Mounted-Steering-Wheel: "Arrrr... it's driving me nuts!"
X-Alameda: WHY DOESN'T ANYONE KNOW ABOUT ALAMEDA?  IT'S RIGHT NEXT TO
 OAKLAND!!!
Organization: The Emadonics Institute
Mail-Followup-To: linux-kernel@vger.kernel.org
Date: Tue, 04 Mar 2003 14:31:31 +0000
In-Reply-To: <20030304141324.GA12185@krispykreme> (Anton Blanchard's message
 of "Wed, 5 Mar 2003 01:13:25 +1100")
Message-ID: <6uisuz5hks.fsf@zork.zork.net>
User-Agent: Gnus/5.090015 (Oort Gnus v0.15) Emacs/21.2
 (i386-debian-linux-gnu)
References: <103200000.1046755559@[10.10.2.4]>
	<20030304141324.GA12185@krispykreme>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

commence  Anton Blanchard quotation:

> Are you running debian? It likes to nice -10 the X server. Renicing it
> back to 0 fixes my xmms skips with 2.5.

You can alter this permanently with 'dpkg-reconfigure xserver-common';
if you elect not to have /etc/X11/Xwrapper.config managed by debconf,
simply edit it directly.

-- 
 /                          |
[|] Sean Neakums            | Size *does* matter.
[|] <sneakums@zork.net>     | That's why I use Emacs.
 \                          |
