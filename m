Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964978AbVLJIV7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964978AbVLJIV7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Dec 2005 03:21:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964976AbVLJITf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Dec 2005 03:19:35 -0500
Received: from mail.kroah.org ([69.55.234.183]:49126 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964965AbVLJITD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Dec 2005 03:19:03 -0500
Date: Sat, 10 Dec 2005 00:18:46 -0800
From: Greg KH <greg@kroah.com>
To: Bao Zhao <baozhaolinuxer@yahoo.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: typo in debugfs code comments?
Message-ID: <20051210081846.GA32220@kroah.com>
References: <20051210025720.GA17847@kroah.com> <20051210075012.87815.qmail@web31715.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051210075012.87815.qmail@web31715.mail.mud.yahoo.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 09, 2005 at 11:50:12PM -0800, Bao Zhao wrote:
> --- linux-2.6.14.3/fs/debugfs/file.c.orig	2005-12-03
> 17:39:41.000000000 -0500
> +++ linux-2.6.14.3/fs/debugfs/file.c	2005-12-03
> 17:41:15.000000000 -0500
> @@ -98,7 +98,7 @@ static u64 debugfs_u16_get(void
> *data)
>  DEFINE_SIMPLE_ATTRIBUTE(fops_u16, debugfs_u16_get,
> debugfs_u16_set, "%llu\n");

Your patch is linewrapped and can't be applied.  Care to try again?

thanks,

greg k-h
