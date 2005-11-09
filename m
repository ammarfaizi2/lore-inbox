Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030403AbVKICqO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030403AbVKICqO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 21:46:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030404AbVKICqO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 21:46:14 -0500
Received: from mail.kroah.org ([69.55.234.183]:15746 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1030403AbVKICqN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 21:46:13 -0500
Date: Tue, 8 Nov 2005 18:40:23 -0800
From: Greg KH <greg@kroah.com>
To: Ernst Herzberg <earny@net4u.de>
Cc: Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org, stable@kernel.org
Subject: Re: [stable] Re: Linux 2.6.14.1
Message-ID: <20051109024023.GC23537@kroah.com>
References: <20051109010729.GA22439@kroah.com> <200511090323.00448.earny@net4u.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511090323.00448.earny@net4u.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 09, 2005 at 03:22:59AM +0100, Ernst Herzberg wrote:
> [....]
> > Summary of changes from v2.6.13.3 to v2.6.13.4
> > ============================================
> >
> > Al Viro:
> >       CVE-2005-2709 sysctl unregistration oops
> >
> > Greg Kroah-Hartman:
> >       Linux 2.6.14.1
> 
> Hu? Version numbers mixed, or does this BUG also affect 2.6.13.x? 

Sorry about that, that line was cut and pasted from an older email
message and I forgot to update it.  The Changelog on kernel.org shows
that the two entries are correct.

Again, very sorry for any potential confusion.

thanks,

greg k-h
