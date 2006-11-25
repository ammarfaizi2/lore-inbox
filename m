Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967195AbWKYUvy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967195AbWKYUvy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Nov 2006 15:51:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967198AbWKYUvx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Nov 2006 15:51:53 -0500
Received: from dspnet.fr.eu.org ([213.186.44.138]:27152 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S967195AbWKYUvx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Nov 2006 15:51:53 -0500
Date: Sat, 25 Nov 2006 21:51:52 +0100
From: Olivier Galibert <galibert@pobox.com>
To: Andi Kleen <ak@suse.de>
Cc: linux-pci@atrey.karlin.mff.cuni.cz,
       "Hack inc." <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] PCI MMConfig: Detect and support the E7520 and the 945G/GZ/P/PL
Message-ID: <20061125205152.GA18964@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	Andi Kleen <ak@suse.de>, linux-pci@atrey.karlin.mff.cuni.cz,
	"Hack inc." <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>
References: <20061123195137.GA35120@dspnet.fr.eu.org> <200611252034.34378.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200611252034.34378.ak@suse.de>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 25, 2006 at 08:34:34PM +0100, Andi Kleen wrote:
> On Thursday 23 November 2006 20:51, Olivier Galibert wrote:
> 
> > The detection and support should eventually be shared with i386 since
> > you can run a 32bits kernel on a 64bits chip.
> 
> Exactly. So please define a mmconfig-shared.c first

Ok.  On which side (i386 or x86-64) and is there a standard way to
include the object file on the other side?

  OG.

