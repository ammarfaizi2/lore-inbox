Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266626AbUJFBa2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266626AbUJFBa2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 21:30:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266627AbUJFBa2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 21:30:28 -0400
Received: from fw.osdl.org ([65.172.181.6]:33454 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266626AbUJFBaO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 21:30:14 -0400
Date: Tue, 5 Oct 2004 18:27:16 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: crash77a@allvantage.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Converting kernel modules from 2.4 to 2.6/Suggested new driver
Message-Id: <20041005182716.2f3f52c0.rddunlap@osdl.org>
In-Reply-To: <416345C0.4050500@allvantage.com>
References: <416345C0.4050500@allvantage.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 05 Oct 2004 21:09:20 -0400 Kenny Bentley wrote:

| Hello.
| 
| Does anyone know if there is a detailed guide on how to convert kernel 
| modules for 2.4 kernels to modules for 2.6 kernels?  I know very little 
| about kernel module programming and haven't done any programming for a 
| long time, although I do have a programming background, and I have 
| drivers for HSF modems and Riptide sound cards that I want to convert 
| from 2.4 modules to 2.6 modules, which shouldn't be too hard.  But I'll 
| need a detailed guide to do it.

http://lwn.net/Articles/driver-porting/

| Or since I've never done any kernel programming, I have a better idea.  
| I want to recommend the drivers for inclusion into the official kernel 
| tree.  The drivers were released open-source by Linuxant or the 
| manufacturer, I don't remember which one for sure.  But they're not 
| being developed any further, and the Riptide sound card driver only 
| supports OSS, and doesn't support ALSA.  Also, there are things in the 

OSS is deprecated.  It needs an ALSA driver.

| drivers that need fixing that surely a lot of you can do much better 
| than me.  I can help test the revised modules and I know how to put them 
| in the kernel tree, so I can do those parts.  But many of you can do the 
| programming better than I can.

You can recommend them for inclusion, but the developer or maintainer
of them needs to either submit them or at least approve their
submission for inclusion.

| I can't afford new hardware right now, and I had to search the net for 
| hours and maybe even days just to find these drivers, and almost gave up 
| hope of being able to use GNU/Linux as my primary OS.  I wouldn't want 
| others to have to go through that or settle for mediocre drivers.  If 
| there are any takers out there, just send me an E-mail and I'll send you 
| the drivers so you can hack away.  But at the very least I'd like to 
| know where I can find a detailed guild on how to convert kernel modules 
| from 2.4 to 2.6.

How about posting their web locations (wherever you found them)
in case someone is interested..?

--
~Randy
