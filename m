Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965187AbVLVU0h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965187AbVLVU0h (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 15:26:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965186AbVLVU0h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 15:26:37 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:36746 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S965182AbVLVU0g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 15:26:36 -0500
Date: Thu, 22 Dec 2005 14:26:27 -0600
From: Mark Maule <maule@sgi.com>
To: Greg KH <gregkh@suse.de>
Cc: linuxppc64-dev@ozlabs.org, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH 0/3] msi abstractions and support for altix
Message-ID: <20051222202627.GI17552@sgi.com>
References: <20051222201651.2019.37913.96422@lnx-maule.americas.sgi.com> <20051222202259.GA4959@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051222202259.GA4959@suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 22, 2005 at 12:22:59PM -0800, Greg KH wrote:
> On Thu, Dec 22, 2005 at 02:15:44PM -0600, Mark Maule wrote:
> > Resend #2: including linuxppc64-dev and linux-pci as well as PCI maintainer
> 
> I'll wait for Resend #3 based on my previous comments before considering
> adding it to my kernel trees:)
> 

Resend #2 includes the correction to the irq_vector[] declaration, and I
responded to the question about setting irq_vector[0] if that's what you
mean ...

Mark
