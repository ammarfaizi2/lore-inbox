Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750898AbWAITUw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750898AbWAITUw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 14:20:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751142AbWAITUw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 14:20:52 -0500
Received: from mail.kroah.org ([69.55.234.183]:19372 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750898AbWAITUu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 14:20:50 -0500
Date: Mon, 9 Jan 2006 11:20:15 -0800
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Greg KH <gregkh@suse.de>, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz, Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [GIT PATCH] PCI patches for 2.6.15
Message-ID: <20060109192015.GB22881@kroah.com>
References: <20060106063716.GA4425@kroah.com> <20060109040318.73e522af.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060109040318.73e522af.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 09, 2006 at 04:03:18AM -0800, Andrew Morton wrote:
> Greg KH <gregkh@suse.de> wrote:
> >
> >  Jeff Garzik:
> >        x86 PCI domain support: the meat
> 
> I have an old ad450nx quad Xeon which I (very) occasionally turn on.  This
> patch kills it.

Yeah, I'm going to hold off on sending this to Linus until it gets
sorted out (it also kills newer IBM boxes too :(

Jeff, care to work on fixing this?

thanks,

greg k-h
