Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261234AbUCALrZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 06:47:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261227AbUCALrZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 06:47:25 -0500
Received: from mail.tpgi.com.au ([203.12.160.100]:18387 "EHLO
	mail5.tpgi.com.au") by vger.kernel.org with ESMTP id S261242AbUCALqz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 06:46:55 -0500
Subject: Re: Dropping CONFIG_PM_DISK?
From: Nigel Cunningham <ncunningham@users.sourceforge.net>
Reply-To: ncunningham@users.sourceforge.net
To: Pavel Machek <pavel@ucw.cz>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Andrew Morton <akpm@zip.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@osdl.org>
In-Reply-To: <20040229124052.GB283@elf.ucw.cz>
References: <20040228230039.GA246@elf.ucw.cz>
	 <1078012320.906.9.camel@gaston> <20040229072959.GB209@elf.ucw.cz>
	 <1078039327.904.36.camel@gaston>  <20040229124052.GB283@elf.ucw.cz>
Content-Type: text/plain
Message-Id: <1078124567.3883.1.camel@laptop-linux.wpcb.org.au>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4-8mdk 
Date: Mon, 01 Mar 2004 22:46:08 +1300
Content-Transfer-Encoding: 7bit
X-TPG-Antivirus: Passed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'd like to work on patching it into suspend2. I'm being real slow at
the moment because I'm not working on suspend much at all, but that
doesn't mean I don't want to do anything :>

Regards,

Nigel

On Mon, 2004-03-01 at 01:40, Pavel Machek wrote:
> Hi!
> 
> > > > Except that pmdisk code is +/- readable, swsusp is not...
> > > 
> > > Would you be willing to either maintain pmdisk or (preffered) split it
> > > up and submit me pieces?
> > 
> > Heh, if I had time ... :)
> 
> Well, unless someone steps up, I guess I'll just let it bitrot, and
> when its broken enough, I'll attempt removal. I really do not have
> time to maintain two implementations...
> 								Pavel
-- 
My work on Software Suspend was graciously brought to you between
October and January by LinuxFund.org.

