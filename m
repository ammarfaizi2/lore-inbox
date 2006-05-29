Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751191AbWE2TDc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751191AbWE2TDc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 15:03:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751194AbWE2TDc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 15:03:32 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:945 "EHLO ZenIV.linux.org.uk")
	by vger.kernel.org with ESMTP id S1751191AbWE2TDb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 15:03:31 -0400
Date: Mon, 29 May 2006 20:03:27 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Nick Warne <nick@linicks.net>
Cc: Jesper Juhl <jesper.juhl@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Question on Space.c
Message-ID: <20060529190327.GT27946@ftp.linux.org.uk>
References: <200605291849.04769.nick@linicks.net> <9a8748490605291105v42e66303pbb45fdccec3a13e4@mail.gmail.com> <200605291911.25836.nick@linicks.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200605291911.25836.nick@linicks.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 29, 2006 at 07:11:25PM +0100, Nick Warne wrote:
> > drivers/scsi/NCR5380.c, include/asm-m68knommu/MC68328.h,
> > drivers/block/DAC960.c and others).
> > To find some more, try this in the kernel source dir : find ./ -name
> > "[A-Z]*"
> >
> > It would make sense to me personally to rename this one, but it's not
> > my call and besides it'll open a whole can of worms about whether or
> > not to rename the other ones...
> 
> Well, I don't think so.  Apart from the really conventional file names 
> (Makefile et al), the others you mentioned are abbreviations*, so it is 
> obvious.  Now Ncr5380.c would be a different kettle of fish...
> 
> Nick
> * abbreviation: a long word used to describe a short word used in place of a 
> long word.

Right...  Now look for definition of acronym somewhere...
