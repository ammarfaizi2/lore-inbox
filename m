Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290235AbSAXCnb>; Wed, 23 Jan 2002 21:43:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290236AbSAXCnL>; Wed, 23 Jan 2002 21:43:11 -0500
Received: from khan.acc.umu.se ([130.239.18.139]:33008 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id <S290235AbSAXCnF>;
	Wed, 23 Jan 2002 21:43:05 -0500
Date: Thu, 24 Jan 2002 03:42:59 +0100
From: David Weinehall <tao@acc.umu.se>
To: Ruben Puettmann <ruben.puettmann@freenet-ag.de>
Cc: Mark Hahn <hahn@physics.mcmaster.ca>, linux-kernel@vger.kernel.org
Subject: Re: Problems compiling 2.4.18-pre6
Message-ID: <20020124034259.T1735@khan.acc.umu.se>
In-Reply-To: <Pine.LNX.4.33.0201231710330.24338-100000@coffee.psychology.mcmaster.ca> <3C4F57AA.7010809@freenet-ag.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3C4F57AA.7010809@freenet-ag.de>; from ruben.puettmann@freenet-ag.de on Thu, Jan 24, 2002 at 01:39:06AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Hahn wrote:

>>Distribution Debian woody with all updates.
>>
> 
> which is exactly the problem.  have the debian people fixed
> this yet?  there have been dozens of reports of this debian 
> problem over many weeks.

This is _NOT_ a Debian problem, it is a matter of buggy code in the
kernel. A newer set of binutils simply exposes the bug. Don't blame
the messenger.


Regards: David Weinehall
  _                                                                 _
 // David Weinehall <tao@acc.umu.se> /> Northern lights wander      \\
//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
\>  http://www.acc.umu.se/~tao/    </   Full colour fire           </
