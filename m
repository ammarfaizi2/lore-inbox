Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030271AbWCHXHV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030271AbWCHXHV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 18:07:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030266AbWCHXHV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 18:07:21 -0500
Received: from smtp.osdl.org ([65.172.181.4]:30629 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030272AbWCHXHU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 18:07:20 -0500
Date: Wed, 8 Mar 2006 15:03:47 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Greg KH <gregkh@suse.de>
cc: Adrian Bunk <bunk@stusta.de>, akpm@osdl.org, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz,
       pcihpd-discuss@lists.sourceforge.net
Subject: Re: State of the Linux PCI and PCI Hotplug Subsystems for 2.6.16-rc5
In-Reply-To: <20060308225029.GA26117@suse.de>
Message-ID: <Pine.LNX.4.64.0603081502350.32577@g5.osdl.org>
References: <20060306223545.GA20885@kroah.com> <20060308222652.GR4006@stusta.de>
 <20060308225029.GA26117@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 8 Mar 2006, Greg KH wrote:
> 
> None, as I am expecting 2.6.16 to be out any day now.

Sadly, until the FC5 problems re at least somewhat more understood, I 
don't think that's going to happen.

Trying to chase down Andrew's "laptop from hell" has also delayed even 
doing a -rc6, although that is imminent.

		Linus
