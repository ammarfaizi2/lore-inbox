Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268254AbRHAVQP>; Wed, 1 Aug 2001 17:16:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268264AbRHAVQF>; Wed, 1 Aug 2001 17:16:05 -0400
Received: from rj.sgi.com ([204.94.215.100]:718 "EHLO rj.corp.sgi.com")
	by vger.kernel.org with ESMTP id <S268265AbRHAVP7>;
	Wed, 1 Aug 2001 17:15:59 -0400
Message-Id: <200108011830.f71IUN203982@jen.americas.sgi.com>
To: =?iso-8859-1?Q?Ragnar_Kj=F8rstad?= <xfs@ragnark.vestdata.no>
cc: Tony Gale <gale@syntax.dera.gov.uk>, Tad Dolphay <tbd@sgi.com>,
        mjacob@feral.com, Christian Chip <chip.christian@storageapps.com>,
        linux-xfs@oss.sgi.com, linux-kernel@vger.kernel.org,
        nfs@lists.sourceforge.net
Subject: Re: Busy inodes after umount 
In-Reply-To: <20010719165758.D50024-100000@wonky.feral.com> <200107200038.TAA40153@fsgi158.americas.sgi.com> <20010731021546.A7750@vestdata.no> <996653920.2941.0.camel@syntax.dera.gov.uk> <20010801200550.B30796@vestdata.no>
Comments: In-reply-to =?iso-8859-1?Q?Ragnar_Kj=F8rstad?= <xfs@ragnark.vestdata.no>
   message dated "Wed, 01 Aug 2001 20:05:50 +0200."
Date: Wed, 01 Aug 2001 13:30:22 -0500
From: Steve Lord <lord@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, Aug 01, 2001 at 09:18:40AM +0100, Tony Gale wrote:
> > Do you have any other patches in your kernel, such as grsecurity?
> 
> The only patch I have is the xfs patch.
> 
> 

I thought Trond pointed to a patch on linux-kernel this morning:

The NLM lock reclaiming code in the stock 2.4.x kernel is
incomplete. Please apply the patch on

   http://www.fys.uio.no/~trondmy/src/2.4.7/linux-2.4.7-reclaim.dif

Cheers,
   Trond

Steve

> 
> -- 
> Ragnar Kjorstad
> Big Storage
