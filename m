Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262796AbSKYJwi>; Mon, 25 Nov 2002 04:52:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262803AbSKYJwi>; Mon, 25 Nov 2002 04:52:38 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:36618
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S262796AbSKYJwh>; Mon, 25 Nov 2002 04:52:37 -0500
Date: Mon, 25 Nov 2002 01:58:31 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Robert Love <rml@tech9.net>
cc: paul_wu@wnexus.com.tw, Tommy Reynolds <reynolds@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Which embedded linux is better for being a router? eCos? uclinux?
In-Reply-To: <1038191030.776.67.camel@phantasy>
Message-ID: <Pine.LNX.4.10.10211250156130.13936-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


What do you have in the way for x86 environments and where is the legalise
for indemnification?  The latter part can be negated if the offerings are
not Linux based.

Andre Hedrick
LAD Storage Consulting Group

On 24 Nov 2002, Robert Love wrote:

> On Sun, 2002-11-24 at 20:01, paul_wu@wnexus.com.tw wrote:
> 
> > CPU will be MIPS. Does uclinux support multi-processes? Or there
> > is 3rd choice for such embedded Linux?
> 
> You do not need any special version of Linux.  Your chip has an MMU and
> all the other normal bits.  Just compile up a stock kernel and
> user-land.
> 
> If you want an already-done distribution, there are a few out there -
> google around.  Commercial offerings are available from MontaVista, Red
> Hat, etc, too.
> 
> 	Robert Love
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

