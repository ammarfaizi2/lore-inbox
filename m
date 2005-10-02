Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932072AbVJBUz3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932072AbVJBUz3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Oct 2005 16:55:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932069AbVJBUz3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Oct 2005 16:55:29 -0400
Received: from mail.kroah.org ([69.55.234.183]:60893 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932072AbVJBUz2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Oct 2005 16:55:28 -0400
Date: Sun, 2 Oct 2005 13:52:57 -0700
From: Greg KH <greg@kroah.com>
To: Frieder B??rzele <linux-stuff@arcor.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: oops in ohci_hcd with kernel 2.6.12 - 2.6.14-rc3-git2
Message-ID: <20051002205257.GB28154@kroah.com>
References: <433FFEA2.3050103@arcor.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <433FFEA2.3050103@arcor.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 02, 2005 at 05:37:06PM +0200, Frieder B??rzele wrote:
> Hi,
> 
> since kernel version ~2.6.12 I occasionally get oopes with the ohci_hcd
> modul during boot.
> I need to reboot 5 times or more until the machine works.
> 
> mainboard is a Asus A7N266-C with nforce chipset

Care to file this in a bug at bugzilla.kernel.org?

thanks,

greg k-h
