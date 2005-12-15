Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751056AbVLOUbM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751056AbVLOUbM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 15:31:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751042AbVLOUas
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 15:30:48 -0500
Received: from mail.kroah.org ([69.55.234.183]:65241 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751045AbVLOUaq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 15:30:46 -0500
Date: Thu, 15 Dec 2005 12:23:59 -0800
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: torvalds@osdl.org
Subject: Re: Linux 2.6.13.5
Message-ID: <20051215202359.GC18213@kroah.com>
References: <20051215202204.GA18213@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051215202204.GA18213@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 15, 2005 at 12:22:04PM -0800, Greg KH wrote:
> Al Viro:
>       CVE-2005-2709 sysctl unregistration oops

Yes, for those of you paying attention, this patch wasn't in the review
queue, but people asked for it to be included as it fixed a security
problem.  The patch came directly from the 2.6.14.y tree.

thanks,

greg k-h
