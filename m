Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261643AbREUUSg>; Mon, 21 May 2001 16:18:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261653AbREUUS0>; Mon, 21 May 2001 16:18:26 -0400
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:41220 "EHLO
	bug.ucw.cz") by vger.kernel.org with ESMTP id <S261643AbREUUSI>;
	Mon, 21 May 2001 16:18:08 -0400
Message-ID: <20010520215300.A2647@bug.ucw.cz>
Date: Sun, 20 May 2001 21:53:00 +0200
From: Pavel Machek <pavel@suse.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Ben LaHaise <bcrl@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFD w/info-PATCH] device arguments from lookup, partion code
In-Reply-To: <Pine.LNX.4.33.0105191153400.5829-100000@devserv.devel.redhat.com> <E1519Xe-00005c-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <E1519Xe-00005c-00@the-village.bc.nu>; from Alan Cox on Sat, May 19, 2001 at 05:25:22PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Now that I'm awake and refreshed, yeah, that's awful.  But
> > echo "hot-add,slot=5,device=/dev/sda" >/dev/md0/control *is* sane.  Heck,
> > the system can even send back result codes that way.
> 
> Only to an English speaker. I suspect Quebec City canadians would prefer a
> different command set.

Alan, bad idea.

This is less evil than magic numbers, and *users* should not be
touching this anyway. They should have nice gui tools that do it for
them.

English is *way* better than magic numbers. It makes sense at least
for someone.
								    Pavel 

-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
