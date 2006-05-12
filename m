Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932126AbWELPRS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932126AbWELPRS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 11:17:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932128AbWELPRS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 11:17:18 -0400
Received: from cantor2.suse.de ([195.135.220.15]:4249 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932126AbWELPRR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 11:17:17 -0400
Date: Fri, 12 May 2006 08:15:24 -0700
From: Greg KH <greg@kroah.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Pavel Machek <pavel@suse.cz>, kernel list <linux-kernel@vger.kernel.org>,
       Carl-Daniel Hailfinger <c-d.hailfinger.devel.2006@gmx.net>,
       trenn@suse.de, thoenig@suse.de, stable@kernel.org
Subject: Re: [stable] Re: [patch] smbus unhiding kills thermal management
Message-ID: <20060512151524.GB22871@kroah.com>
References: <20060512095343.GA28375@elf.ucw.cz> <44645FC2.80500@gmx.net> <20060512102004.GD28232@elf.ucw.cz> <Pine.LNX.4.61.0605121248540.9918@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0605121248540.9918@yvahk01.tjqt.qr>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 12, 2006 at 12:49:24PM +0200, Jan Engelhardt wrote:
> >> 
> >> This is probably also -stable material.
> >
> >Yes, I'd like to see it go into -stable. (But IIRC stable rules were
> >"mainline first").
> 
> That rule was already broken IIRC.

For non-security issues?  The rule is, "accepted by mainline".  So has
the maintainer accepted this yet or not?

thanks,

greg k-h
