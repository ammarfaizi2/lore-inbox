Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290475AbSBFM1u>; Wed, 6 Feb 2002 07:27:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290490AbSBFM1l>; Wed, 6 Feb 2002 07:27:41 -0500
Received: from khan.acc.umu.se ([130.239.18.139]:21439 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id <S290475AbSBFM1b>;
	Wed, 6 Feb 2002 07:27:31 -0500
Date: Wed, 6 Feb 2002 13:27:27 +0100
From: David Weinehall <tao@acc.umu.se>
To: =?iso-8859-1?Q?Hanno_B=F6ck?= <hanno@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Patch for eepro100 to support more cards
Message-ID: <20020206132727.H1735@khan.acc.umu.se>
In-Reply-To: <20020201080545Z291604-13996+15441@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020201080545Z291604-13996+15441@vger.kernel.org>; from hanno@gmx.de on Fri, Feb 01, 2002 at 09:06:26AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 01, 2002 at 09:06:26AM +0100, Hanno Böck wrote:
> This patch adds support for the
> Intel Pro/100 VE
> Network card to the eepro100.c
> 
> This card is installed in my notebook (Sony Vaio PCG-GR114MK). Seems to work 
> fine.

Nice!

[snip]

> +#ifndef PCI_DEVICE_ID_INTEL_ID1031	// Support for Intel Pro/100 
> VE added by Hanno Boeck <hanno@gmx.de>

[snip]

PLEASE put this kind of comments in the changelog or similarly fitting
place instead of in the code. If everyone had their e-mail address
in a comment after every line they added, would be bloated beyond
proportions (some argue that it already is, but let's ignore that for
now...)


Regards: David Weinehall
  _                                                                 _
 // David Weinehall <tao@acc.umu.se> /> Northern lights wander      \\
//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
\>  http://www.acc.umu.se/~tao/    </   Full colour fire           </
