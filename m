Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750790AbVLBV50@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750790AbVLBV50 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 16:57:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750799AbVLBV50
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 16:57:26 -0500
Received: from fmr23.intel.com ([143.183.121.15]:35789 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S1750790AbVLBV5Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 16:57:25 -0500
Date: Fri, 2 Dec 2005 13:57:15 -0800
From: Rajesh Shah <rajesh.shah@intel.com>
To: Greg KH <gregkh@suse.de>
Cc: Jeff Garzik <jgarzik@pobox.com>, rajesh.shah@intel.com,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Matthew Wilcox <matthew@wil.cx>, "Brown, Len" <len.brown@intel.com>
Subject: Re: [2.6.15-rc4] oops in acpiphp
Message-ID: <20051202135715.D22130@unix-os.sc.intel.com>
Reply-To: Rajesh Shah <rajesh.shah@intel.com>
References: <4390B646.60709@pobox.com> <20051202214655.GA13599@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20051202214655.GA13599@suse.de>; from gregkh@suse.de on Fri, Dec 02, 2005 at 01:46:55PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 02, 2005 at 01:46:55PM -0800, Greg KH wrote:
> On Fri, Dec 02, 2005 at 04:01:58PM -0500, Jeff Garzik wrote:
> > 
> > Booting with acpiphp on this dual core, dual package (2x2) box causes an 
> > oops.
> 
> Ok, I've heard about this one before, in looking closer at this.  Rajesh
> is aware of this one (right Rajesh?  I'll bounce you the original
> message).  I'll let him take it from here...
> 
Yes, I'm aware of this as of last week, never tried with the
config option set to "y" previously. I'll look into this as
part of the pciehp rework.

thanks,
Rajesh
