Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266675AbSKUOKj>; Thu, 21 Nov 2002 09:10:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266676AbSKUOKj>; Thu, 21 Nov 2002 09:10:39 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:54661 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S266675AbSKUOKi>; Thu, 21 Nov 2002 09:10:38 -0500
Subject: Re: Compiling x86 with and without frame pointer
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Dave Jones <davej@codemonkey.org.uk>
Cc: Keith Owens <kaos@ocs.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021121125554.GA9883@suse.de>
References: <19005.1037854033@kao2.melbourne.sgi.com> 
	<20021121125554.GA9883@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 21 Nov 2002 14:46:22 +0000
Message-Id: <1037889982.7845.4.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-11-21 at 12:55, Dave Jones wrote:
> On Thu, Nov 21, 2002 at 03:47:13PM +1100, Keith Owens wrote:
>  > The conventional wisdom is that compiling x86 without frame pointer
>  > results in smaller code.  It turns out to be the opposite, compiling
>  > with frame pointers results in a smaller kernel.  gcc version 3.2
>  > 20020822 (Red Hat Linux Rawhide 3.2-4).
> 
> I've been pushing a forward port of the CONFIG_FRAME_POINTER changes
> that went into 2.4 for a while, but Linus hasn't taken them each time.
> I'll keep pushing until I get a comment..

Send it this way 8)

