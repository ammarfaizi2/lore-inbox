Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262873AbUFWX6Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262873AbUFWX6Y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 19:58:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263001AbUFWX6Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 19:58:24 -0400
Received: from mail.kroah.org ([65.200.24.183]:31937 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262873AbUFWX6X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 19:58:23 -0400
Date: Wed, 23 Jun 2004 16:55:38 -0700
From: Greg KH <greg@kroah.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: jeremy.katz@gmail.com, akpm@osdl.org, jgarzik@pobox.com, katzj@redhat.com,
       linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH] PPC64 iSeries viodasd proc file
Message-ID: <20040623235538.GA22791@kroah.com>
References: <200406232354.i5NNsnCL029470@supreme.pcug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200406232354.i5NNsnCL029470@supreme.pcug.org.au>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 24, 2004 at 09:54:49AM +1000, Stephen Rothwell wrote:
> From: Greg KH <greg@kroah.com>
> > 
> > I agree, I don't think that many things have disappeared from /proc just
> > yet, right?  You should just have more information than what you
> > previously did, right?  Or did scsi drop their /proc support fully?
> 
> What started this discussion is that I had to drop all the proc support
> from the iSeries virtual devices while attempting to get the drivers
> into the mainline kernel.

Ok, but that support was never in mainline, right?  :)

Yeah I know, distro trees...

greg k-h
