Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932252AbVKFVxj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932252AbVKFVxj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 16:53:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932256AbVKFVxj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 16:53:39 -0500
Received: from mail.kroah.org ([69.55.234.183]:23680 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932252AbVKFVxi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 16:53:38 -0500
Date: Sun, 6 Nov 2005 13:51:59 -0800
From: Greg KH <greg@kroah.com>
To: Harald Dunkel <harald.dunkel@t-online.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.14, udev: unknown symbols for ehci_hcd
Message-ID: <20051106215158.GB3603@kroah.com>
References: <436CD1BC.8020102@t-online.de> <20051105162503.GC20686@kroah.com> <436D9BDE.3060404@t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <436D9BDE.3060404@t-online.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 06, 2005 at 06:59:58AM +0100, Harald Dunkel wrote:
> Greg KH wrote:
> > On Sat, Nov 05, 2005 at 04:37:32PM +0100, Harald Dunkel wrote:
> > 
> >>Hi folks,
> >>
> >>I can't say since when this problem is in, but currently
> >>I get error messages about unknown symbols at boot time
> >>(after mounting the root disk, as it seems):
> > 
> > 
> > Are you using Debian?
> > 
> Of course :=)

This seems to be a Debian issue for some odd reason, I suggest filing a
bug against the udev package (or just tagging onto the existing bug for
this problem, I've seen it in there already...)

Good luck,

greg k-h
