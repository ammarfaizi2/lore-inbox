Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262796AbTIESCz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 14:02:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265399AbTIESCy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 14:02:54 -0400
Received: from havoc.gtf.org ([63.247.75.124]:39059 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S262796AbTIESCx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 14:02:53 -0400
Date: Fri, 5 Sep 2003 14:02:48 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Patrick Mochel <mochel@osdl.org>
Cc: Rob Landley <rob@landley.net>, Pavel Machek <pavel@suse.cz>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Fix up power managment in 2.6
Message-ID: <20030905180248.GB29353@gtf.org>
References: <200309050158.36447.rob@landley.net> <Pine.LNX.4.44.0309051044470.17174-100000@cherise>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0309051044470.17174-100000@cherise>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 05, 2003 at 10:47:49AM -0700, Patrick Mochel wrote:
> > the power LED still on and the hibernate light off, and the thing's a brick 
> > at that point; the only thing you can do is hold the power button down for 
> > ten seconds or pop the battery to get it to boot back up from scratch.)  So I 
> > have to shut the sucker down every time I want to move it, which is a pain...
> 
> What model is it? It probably doesn't support APM at all. I can't
> guarantee that ACPI suspend/resume will work on it, but I'm interested to 
> see if it does.. 


Note that a lot of ThinkPads out in the field need a BIOS update
before their ACPI is working.  (I know this because IBM was quite
helpful and proactive in addressing their Linux-related ACPI BIOS
issues)

	Jeff



