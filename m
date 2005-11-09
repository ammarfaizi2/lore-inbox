Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030506AbVKICd7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030506AbVKICd7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 21:33:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965237AbVKICd7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 21:33:59 -0500
Received: from smtp.osdl.org ([65.172.181.4]:42460 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965156AbVKICd6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 21:33:58 -0500
Date: Tue, 8 Nov 2005 18:33:46 -0800
From: Chris Wright <chrisw@osdl.org>
To: Ernst Herzberg <earny@net4u.de>
Cc: Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org, stable@kernel.org
Subject: Re: [stable] Re: Linux 2.6.14.1
Message-ID: <20051109023346.GA5856@shell0.pdx.osdl.net>
References: <20051109010729.GA22439@kroah.com> <200511090323.00448.earny@net4u.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511090323.00448.earny@net4u.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Ernst Herzberg (earny@net4u.de) wrote:
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

Yes, both a mixup in the message, and it effects older kernels.

thanks,
-chris
