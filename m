Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314835AbSGMPqw>; Sat, 13 Jul 2002 11:46:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315120AbSGMPqv>; Sat, 13 Jul 2002 11:46:51 -0400
Received: from dingo.clsp.jhu.edu ([128.220.34.67]:29389 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S314835AbSGMPqv>;
	Sat, 13 Jul 2002 11:46:51 -0400
Date: Sat, 13 Jul 2002 16:15:44 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Alan Cox <alan@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.19-rc1-ac3
Message-ID: <20020713141543.GC163@elf.ucw.cz>
References: <200207121914.g6CJEcN32497@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200207121914.g6CJEcN32497@devserv.devel.redhat.com>
User-Agent: Mutt/1.3.28i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> [+ indicates stuff that went to Marcelo, o stuff that has not,
>  * indicates stuff that is merged in mainstream now, X stuff that proved
>    bad and was dropped out]
> 
> This is mostly a housekeeping patch designed to shrink diff sizes down
> and get ready for 2.4.20pre merging. Promise users please test this with
> *caution*. It should fix large drives on the 20262/3 but change nothing
> else but namings.
> 
> Linux 2.4.19rc1-ac3
> o	Remove SWSUSPEND
> 	| With the IDE backport option and other general 2.5 improvements
> 	| its now best worked on in 2.5

Do you have this patch separated somewhere? Lot of people still looks
interested in 2.4. [If you don't I'll probably just extract it from
ac2-to-ac3 diff].
								Pavel
-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
