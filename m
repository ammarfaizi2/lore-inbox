Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264510AbTL1D5p (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Dec 2003 22:57:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264511AbTL1D5o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Dec 2003 22:57:44 -0500
Received: from [64.65.177.98] ([64.65.177.98]:10460 "EHLO mail.pacrimopen.com")
	by vger.kernel.org with ESMTP id S264510AbTL1D5n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Dec 2003 22:57:43 -0500
Subject: Re: 2.7 (future kernel) wish
From: Joshua Schmidlkofer <kernel@pacrimopen.com>
To: Jim Crilly <jim@why.dont.jablowme.net>
Cc: "David B. Stevens" <dsteven3@maine.rr.com>,
       Helge Hafting <helgehaf@aitel.hist.no>, Jos Hulzink <josh@stack.nl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3FEE47F5.6090406@why.dont.jablowme.net>
References: <200312232342.17532.josh@stack.nl>
	 <20031226233855.GA476@hh.idb.hist.no>  <3FECCAF9.7070209@maine.rr.com>
	 <1072507896.27022.226.camel@menion.home>
	 <3FEE47F5.6090406@why.dont.jablowme.net>
Content-Type: text/plain
Message-Id: <1072583848.32719.7.camel@menion.home>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 27 Dec 2003 19:57:29 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >
> Generally it just complains that you pulled out the device prematurely, 
> I've never seen one give a STOP error from that but I guess a bad driver 
> or USB controller could cause anything.
> 


Generally, yes.  But it is not over-statement to say 'sometimes'.  I
have seen this quite a bit. =(.  So I try not to pull devices w/o using
'Safely Remove...'

> When you insert a device like a USB stick Windows puts a little icon 
> next to the clock in the system tray that you're supposed to use to stop 
> the device before pulling it, effectively it unmounts and stops (or 
> atleast releases the device from) the driver so the device can be 
> 'safely' removed.

I am aware of this, =).  I was just commenting that yanking the device
in Windows - is not that much different from Linux.

Now, I would like to see the HAL type crap for Linux. It would be nice
to have uniform user device control from a gui programmable means.

js


-- 
VB programmers ask why no one takes them seriously, 
it's somewhat akin to a McDonalds manager asking employees 
why they don't take their 'career' seriously.

