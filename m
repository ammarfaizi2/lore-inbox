Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261357AbTIGTQV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 15:16:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261307AbTIGTQV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 15:16:21 -0400
Received: from oasis.frogfoot.net ([168.210.54.51]:46786 "HELO
	oasis.frogfoot.net") by vger.kernel.org with SMTP id S261357AbTIGTQT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 15:16:19 -0400
Date: Sun, 7 Sep 2003 21:15:52 +0200
From: Abraham van der Merwe <abz@frogfoot.net>
To: Fedor Karpelevitch <fedor@karpelevitch.net>
Cc: Linux Kernel Discussions <linux-kernel@vger.kernel.org>
Subject: Re: BUG: 2.4.23-pre3 + ifconfig
Message-ID: <20030907191552.GA26123@oasis.frogfoot.net>
Mail-Followup-To: Fedor Karpelevitch <fedor@karpelevitch.net>,
	Linux Kernel Discussions <linux-kernel@vger.kernel.org>
References: <20030904180554.GA21536@oasis.frogfoot.net> <200309071217.03470.fedor@karpelevitch.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200309071217.03470.fedor@karpelevitch.net>
User-Agent: Mutt/1.3.28i
Organization: Frogfoot Networks CC
X-Operating-System: Debian GNU/Linux oasis 2.4.21 (i686)
X-GPG-Public-Key: http://oasis.frogfoot.net/keys/
X-Uptime: 21:14:30 up 19 days, 2:29, 11 users, load average: 0.03, 0.02, 0.00
X-Edited-With-Muttmode: muttmail.sl - 2001-09-27
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fedor                                         >@2003.09.07_21:17:02_+0200

> > I just installed 2.4.23-pre3 on one of our servers. If I up/down
> > the loopback device multiple times ifconfig hangs on the second
> > down (as in unkillable) and afterwards ifconfig stops functioning
> > and I can't reboot the machine, etc.
> >
> > No oopses, kernel panics, messages or anything. The system is still
> > alive, it is just as if some system call is hung.
> >
> > If anyone is interested, I can send my .config or any other
> > relevant details.
> 
> I have the same problem. Did you find any solution?

No :P Not even sure if anyone on lkml noticed my bug report.

-- 

Regards
 Abraham

Carmel, New York, has an ordinance forbidding men to wear coats and
trousers that don't match.

___________________________________________________
 Abraham vd Merwe - Frogfoot Networks CC
 9 Kinnaird Court, 33 Main Street, Newlands, 7700
 Phone: +27 21 686 1665 Cell: +27 82 565 4451
 Http: http://www.frogfoot.net/ Email: abz@frogfoot.net

