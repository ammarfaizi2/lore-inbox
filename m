Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932171AbWIINZk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932171AbWIINZk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Sep 2006 09:25:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932175AbWIINZk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Sep 2006 09:25:40 -0400
Received: from palinux.external.hp.com ([192.25.206.14]:20374 "EHLO
	mail.parisc-linux.org") by vger.kernel.org with ESMTP
	id S932171AbWIINZj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Sep 2006 09:25:39 -0400
Date: Sat, 9 Sep 2006 07:25:38 -0600
From: Matthew Wilcox <matthew@wil.cx>
To: Greg KH <gregkh@suse.de>
Cc: torvalds@osdl.org, Andrew Morton <akpm@osdl.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: Re: State of the Linux PCI Subsystem for 2.6.18-rc6
Message-ID: <20060909132538.GB2638@parisc-linux.org>
References: <20060909081816.GA13058@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060909081816.GA13058@kroah.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 09, 2006 at 01:18:16AM -0700, Greg KH wrote:
> No other new PCI driver API changes are pending that I am aware of.  The

You said you were going to do the s/hotplug_slot/pci_slot/ change for
submission in the next round of patches.
