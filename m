Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751033AbVJTDvB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751033AbVJTDvB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 23:51:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751726AbVJTDvB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 23:51:01 -0400
Received: from mail.kroah.org ([69.55.234.183]:15533 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751031AbVJTDvA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 23:51:00 -0400
Date: Wed, 19 Oct 2005 20:50:14 -0700
From: Greg KH <greg@kroah.com>
To: Aaron Gyes <floam@sh.nu>
Cc: Mathieu Segaud <matt@regala.cx>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.14-rc4-mm1: udev/sysfs wierdness
Message-ID: <20051020035014.GA8995@kroah.com>
References: <1129610113.10504.4.camel@localhost> <20051018055003.GA10488@kroah.com> <20051018065705.GA11858@kroah.com> <87r7ajdy4v.fsf@barad-dur.minas-morgul.org> <20051019034427.GA15940@kroah.com> <1129701608.10192.1.camel@localhost> <20051019234429.GD18295@kroah.com> <1129779251.7743.1.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1129779251.7743.1.camel@localhost>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2005 at 08:34:11PM -0700, Aaron Gyes wrote:
> On Wed, 2005-10-19 at 16:44 -0700, Greg KH wrote:
> > You need a udev update.  071 has been released which should fix this
> > problem (fixes it for me.)  Can you try that out?
> > 
> > thanks,
> > 
> > greg k-h
> 
> Excuse my igorance, but for the life of me I can't find udev 071.
> Obviously it exists somewhere since my distribution (x86_64 Gentoo)
> seems to have a package for it, but it's failing to be able to grab it,
> and I'm unable to find a tarball anywhere at kernel.org

It looks like the kernel.org mirror system got stuck again, the tarball
is sitting on the upload server, but hasn't been mirrored out to the
public side yet.  Give it a few hours...

thanks,

greg k-h
