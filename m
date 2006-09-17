Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965001AbWIRMJR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965001AbWIRMJR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 08:09:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965010AbWIRMJR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 08:09:17 -0400
Received: from mail.kroah.org ([69.55.234.183]:705 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S965001AbWIRMJQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 08:09:16 -0400
Date: Sun, 17 Sep 2006 09:23:32 -0700
From: Greg KH <gregkh@suse.de>
To: Matthew Wilcox <matthew@wil.cx>
Cc: torvalds@osdl.org, Andrew Morton <akpm@osdl.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: Re: State of the Linux PCI Subsystem for 2.6.18-rc6
Message-ID: <20060917162332.GD6326@suse.de>
References: <20060909081816.GA13058@kroah.com> <20060909132538.GB2638@parisc-linux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060909132538.GB2638@parisc-linux.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 09, 2006 at 07:25:38AM -0600, Matthew Wilcox wrote:
> On Sat, Sep 09, 2006 at 01:18:16AM -0700, Greg KH wrote:
> > No other new PCI driver API changes are pending that I am aware of.  The
> 
> You said you were going to do the s/hotplug_slot/pci_slot/ change for
> submission in the next round of patches.

Ah yeah, sorry, that's in my queue, forgot to mention it.

greg k-h
