Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317469AbSHHLjR>; Thu, 8 Aug 2002 07:39:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317471AbSHHLjR>; Thu, 8 Aug 2002 07:39:17 -0400
Received: from khan.acc.umu.se ([130.239.18.139]:7617 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id <S317469AbSHHLjQ>;
	Thu, 8 Aug 2002 07:39:16 -0400
Date: Thu, 8 Aug 2002 13:42:44 +0200
From: David Weinehall <tao@acc.umu.se>
To: Greg Ungerer <gerg@snapgear.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       Amol Lad <dal_loma@yahoo.com>
Subject: Re: uclinux on MMU platforms - query
Message-ID: <20020808114244.GX259@khan.acc.umu.se>
References: <3D50B42B.8000200@snapgear.com> <1028719830.18156.238.camel@irongate.swansea.linux.org.uk> <3D51BC64.4030704@snapgear.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D51BC64.4030704@snapgear.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 08, 2002 at 10:33:40AM +1000, Greg Ungerer wrote:
> Hi Alan,
> 
> Alan Cox wrote:
> >On Wed, 2002-08-07 at 06:46, Greg Ungerer wrote:
> >
> >>>  Can I run uClinux on platforms that has MMU
> >>
> >>You could, but why would you want to?
> >
> >
> >Being able to run true ucLinux on i386 makes debugging and verification
> >of software so much less painful sometimes. 
> 
> For some things yes. But it is a real pain trying to track
> down memory corruption and stack overflow problems in
> applications. They have a tendency to take your the whole system...

Wouldn't an ucLinux-version of uml be a good idea? :-)


Regards: David Weinehall
-- 
 /> David Weinehall <tao@acc.umu.se> /> Northern lights wander      <\
//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
\>  http://www.acc.umu.se/~tao/    </   Full colour fire           </
