Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261199AbVCEVkF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261199AbVCEVkF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 16:40:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261200AbVCEVkF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 16:40:05 -0500
Received: from secure.htb.at ([195.69.104.11]:45060 "EHLO pop3.htb.at")
	by vger.kernel.org with ESMTP id S261199AbVCEVkA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 16:40:00 -0500
Date: Sat, 5 Mar 2005 22:39:45 +0100
From: Richard Mittendorfer <jkerdawn@yahoo.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: s4bios: does anyone use it?
Message-Id: <20050305223945.39c588a5.jkerdawn@yahoo.com>
In-Reply-To: <20050305191405.GA1463@elf.ucw.cz>
References: <20050305191405.GA1463@elf.ucw.cz>
X-Mailer: Sylpheed version 0.9.99-gtk2-20041024 (GTK+ 2.4.14; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanner: exiscan *1D7h02-0004Lu-00*vxVUkElip8c*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Also sprach Pavel Machek <pavel@ucw.cz> (Sat, 5 Mar 2005 20:14:05
+0100):
> Hi!

hi!

> Is there single user of s4bios? It used to work for me 4 notebooks
> ago, but I never really used it. I think I'm the only person that ever
> seen it working, but I could be wrong. Is there anyone using s4bios in
> 2.6.11?
> 
> If not, I guess we should remove that code from kernel. It is not
> usefull, and it is likely broken.
> 								Pavel

it doesn't work here (libretto). it goes to sleep but hangs on wakeup.

would be fine if.. but i'm satisfied with s3 and halt. never tried
swsuspend. also havn't tried since 2.6.9

as 2.6 is IMHO toooo large there should be something done about it (make
it configurable?patchable).

sl ritch.
