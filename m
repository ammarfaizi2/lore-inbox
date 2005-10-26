Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964913AbVJZVMK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964913AbVJZVMK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 17:12:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964926AbVJZVMJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 17:12:09 -0400
Received: from mail.kroah.org ([69.55.234.183]:55007 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964913AbVJZVMI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 17:12:08 -0400
Date: Wed, 26 Oct 2005 14:11:29 -0700
From: Greg KH <greg@kroah.com>
To: Laurent riffard <laurent.riffard@free.fr>
Cc: linux-kernel@vger.kernel.org, Al Viro <viro@ftp.linux.org.uk>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [RFC patch 3/3] remove pci_driver.owner and .name fields
Message-ID: <20051026211129.GA7918@kroah.com>
References: <20051026204802.123045000@antares.localdomain> <20051026204909.995658000@antares.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051026204909.995658000@antares.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 26, 2005 at 10:48:05PM +0200, Laurent riffard wrote:
> This is the final cleanup : deletion of pci_driver.name and .owner
> happens now. 

what?  Did you actually try to build a kernel with this patch applied?

Sorry, but I think we have to wait a long time before this can be
appliedr...

thanks,

greg k-h
