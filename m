Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751150AbWGPShZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751150AbWGPShZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jul 2006 14:37:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751159AbWGPShZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jul 2006 14:37:25 -0400
Received: from tomts45.bellnexxia.net ([209.226.175.112]:25484 "EHLO
	tomts45-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S1751150AbWGPShY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jul 2006 14:37:24 -0400
Date: Sun, 16 Jul 2006 11:31:26 -0700
From: Greg KH <greg@kroah.com>
To: Daniel Drake <dsd@gentoo.org>
Cc: Andrew Morton <akpm@osdl.org>, Jeff Garzik <jeff@garzik.org>, cw@f00f.org,
       harmon@ksu.edu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add SATA device to VIA IRQ quirk fixup list
Message-ID: <20060716183126.GB4483@kroah.com>
References: <20060714095233.5678A8B6253@zog.reactivated.net> <44B77B1A.6060502@garzik.org> <44B78294.1070308@gentoo.org> <44B78538.6030909@garzik.org> <20060714074305.1248b98e.akpm@osdl.org> <44BA48A0.2060008@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44BA48A0.2060008@gentoo.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 16, 2006 at 03:09:36PM +0100, Daniel Drake wrote:
> Andrew,
> 
> Andrew Morton wrote:
> >Guys, this is a really serious failure but afaict nobody is working on it
> >and generally nothing at all is happening.
> >
> >How do we fix all this?  (Who owns it?)
> 
> I'd like to push the attached patch for inclusion. I have tested it on 
> my VIA Apollo system, and I hope it is an acceptable compromise while 
> nobody has a complete understanding of the issues around this quirk.
> 
> I think this belongs to Greg as its a PCI thing, but we should probably 
> look for a yay or nay from Jeff as well.

Looks ok to me, but I'll defer to Jeff for this one.

thanks,

greg k-h
