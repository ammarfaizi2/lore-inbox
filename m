Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261256AbVFDGio@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261256AbVFDGio (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Jun 2005 02:38:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261258AbVFDGio
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Jun 2005 02:38:44 -0400
Received: from lyle.provo.novell.com ([137.65.81.174]:54139 "EHLO
	lyle.provo.novell.com") by vger.kernel.org with ESMTP
	id S261256AbVFDGik (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Jun 2005 02:38:40 -0400
Date: Fri, 3 Jun 2005 23:38:33 -0700
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andreas Koch <koch@esa.informatik.tu-darmstadt.de>,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Devices behind PCI Express-to-PCI bridge not mapped
Message-ID: <20050604063833.GA13238@suse.de>
References: <20050603232828.GA29860@erebor.esa.informatik.tu-darmstadt.de> <Pine.LNX.4.58.0506031706450.1876@ppc970.osdl.org> <20050604013311.GA30151@erebor.esa.informatik.tu-darmstadt.de> <Pine.LNX.4.58.0506031851220.1876@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0506031851220.1876@ppc970.osdl.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 03, 2005 at 06:55:40PM -0700, Linus Torvalds wrote:
> 
> Greg, do you have any PCI Express hw? Although I suspect that the 
> pci_assign_unassigned_resources() problem probably happens on any PC, I 
> could try it on my laptop.

I do not :(

I have some motherboards with PCI Express slots, but I haven't been able
to find any Express cards around town anywhere.

Anyone have any pointers to a simple PCI express network card?  (no, I
don't want a PCI express video card, although if someone wants to send
me one I will not complain...)

thanks,

greg k-h
