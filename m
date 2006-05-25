Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751080AbWEYQPk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751080AbWEYQPk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 12:15:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751032AbWEYQPk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 12:15:40 -0400
Received: from ns.suse.de ([195.135.220.2]:60126 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750777AbWEYQPj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 12:15:39 -0400
Date: Thu, 25 May 2006 09:13:15 -0700
From: Greg KH <greg@kroah.com>
To: Dave Airlie <airlied@gmail.com>
Cc: "D. Hazelton" <dhazelton@enter.net>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Kyle Moffett <mrmacman_g4@mac.com>,
       Manu Abraham <abraham.manu@gmail.com>, linux cbon <linuxcbon@yahoo.fr>,
       Helge Hafting <helge.hafting@aitel.hist.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
Subject: Re: OpenGL-based framebuffer concepts
Message-ID: <20060525161315.GB4379@kroah.com>
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com> <A78F7AE7-C3C2-43DA-9F17-D196CCA7632A@mac.com> <1148379089.25255.9.camel@localhost.localdomain> <200605232338.54177.dhazelton@enter.net> <21d7e9970605232108u27bc3ae7mbd161778c51afaf5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21d7e9970605232108u27bc3ae7mbd161778c51afaf5@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 24, 2006 at 02:08:02PM +1000, Dave Airlie wrote:
> The two attempts I've done, were using a vgaclass device from Alan
> Cox, and also adding a lowlevel driver for the radeon, hotplug became
> my major issue each time, discussions last year at Kernel Summit were
> had, but the results however never surfaced, I'm intending to go to KS
> this year and actually try and get Greg-KH to fix the device model for
> what we need as opposed to hacking the crap out of it.

I think we have what you need already done + a few minor patches.  I
think a few hours of working together will be all that is needed.
Looking forward to it.

greg k-h
