Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261323AbVCPR5M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261323AbVCPR5M (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 12:57:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262714AbVCPR5L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 12:57:11 -0500
Received: from mail.kroah.org ([69.55.234.183]:48073 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261323AbVCPR5I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 12:57:08 -0500
Date: Wed, 16 Mar 2005 09:56:51 -0800
From: Greg KH <greg@kroah.com>
To: "Robert W. Fuller" <orangemagicbus@sbcglobal.net>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.11 USB broken on VIA computer (not just ACPI)
Message-ID: <20050316175649.GD20576@kroah.com>
References: <4237A5C1.5030709@sbcglobal.net> <20050315203914.223771b2.akpm@osdl.org> <4237C40C.6090903@sbcglobal.net> <20050315213110.75ad9fd5.akpm@osdl.org> <4237C61A.6040501@sbcglobal.net> <20050315215447.7975a0ff.akpm@osdl.org> <4237D92A.3040109@sbcglobal.net> <20050316171943.GC8602@kroah.com> <423871EE.5060206@sbcglobal.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <423871EE.5060206@sbcglobal.net>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 16, 2005 at 12:50:38PM -0500, Robert W. Fuller wrote:
> Greg KH wrote:
> >On Wed, Mar 16, 2005 at 01:58:50AM -0500, Robert W. Fuller wrote:
> >>>Are you running the latest BIOS?
> >>The manufacturer, Tyan, didn't produce more than a handful of BIOS'es 
> >>within a matter of months after they started producing the board.  They 
> >>haven't released an update since 2000.
> >I used to have this motherboard, and Randy Dunlap and I spent a lot of
> >time to try to get this to work properly.  Just give up and go by a
> >motherboard that actually has a sane bios, or, buy a USB pci card (less
> >than $20).
> 
> Tempting, but how do I know the new board will work?  Shoot, it took me 
> about a year to get everything in this system to work excepting the USB. 
>  Do you have any recommendations for a good Linux SMP motherboard, 
> preferably for AMD processors?

Get a PCI USB card, that's the easiest solution (and cheapest.)

Good luck,

greg k-h
