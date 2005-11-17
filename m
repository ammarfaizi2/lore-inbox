Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161160AbVKQHPM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161160AbVKQHPM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 02:15:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161157AbVKQHPM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 02:15:12 -0500
Received: from mail.kroah.org ([69.55.234.183]:9093 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1161159AbVKQHPK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 02:15:10 -0500
Date: Wed, 16 Nov 2005 22:56:36 -0800
From: Greg KH <gregkh@suse.de>
To: Michael Kerrisk <mtk-lkml@gmx.net>
Cc: linux-kernel@vger.kernel.org, mtk-manpages@gmx.net
Subject: Re: [RFC] HOWTO do Linux kernel development
Message-ID: <20051117065636.GC20684@suse.de>
References: <20051115173307.GB13707@suse.de> <711.1132128770@www71.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <711.1132128770@www71.gmx.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2005 at 09:12:50AM +0100, Michael Kerrisk wrote:
> Greg,
> 
> Under 'Documentation', there is the text:
> 
>     When new features are added to the kernel, it is recommended 
>     that new documentation files are also added which explain how 
>     to use the feature.
> 
> Could you also add something like:
> 
>     When a new feature changes the interface that the kernel 
>     exposes to userland, it is recommended that you send 
>     information or a man-pages patch explaining the change 
>     to the manual pages maintainer at mtk-manpages@gmx.net.

Do you want to start documenting the sysfs tree interface?  Do you have
man pages for all of the kernel syscalls now?

Anyway, I'll add it, as it is better to error on the side of caution
here.

thanks,

greg k-h
