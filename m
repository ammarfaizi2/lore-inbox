Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317540AbSGXTzt>; Wed, 24 Jul 2002 15:55:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317542AbSGXTzt>; Wed, 24 Jul 2002 15:55:49 -0400
Received: from mortar.viawest.net ([216.87.64.7]:59030 "EHLO
	mortar.viawest.net") by vger.kernel.org with ESMTP
	id <S317540AbSGXTzs>; Wed, 24 Jul 2002 15:55:48 -0400
Date: Wed, 24 Jul 2002 12:58:52 -0700
From: A Guy Called Tyketto <tyketto@wizard.com>
To: Ville Herva <vherva@niksula.hut.fi>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] 2.5.27 floppy driver
Message-ID: <20020724195852.GA21690@wizard.com>
References: <20020724134026.GB479@schottelius.org> <20020724134052.GM1548@niksula.cs.hut.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020724134052.GM1548@niksula.cs.hut.fi>
User-Agent: Mutt/1.4i
X-Operating-System: Linux/2.5.25 (i686)
X-uptime: 12:46pm  up 2 days, 19:42,  2 users,  load average: 0.02, 0.04, 0.05
X-RSA-KeyID: 0xE9DF4D85
X-DSA-KeyID: 0xE319F0BF
X-GPG-Keys: see http://www.wizard.com/~tyketto/pgp.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24, 2002 at 04:40:52PM +0300, Ville Herva wrote:
> On Wed, Jul 24, 2002 at 03:40:26PM +0200, you [Nico Schottelius] wrote:
> > Sorry to disturb again:
> > The floppy driver is broken in this kernel, too.
> > Reading/writing lets the accessing program just 'hang around'.
> > 
> > Luckily the floppy driver is happy and reports its problems to us.
> 
> Seems the same I got with 2.5.26:
> 
> http://groups.google.com/groups?ie=UTF-8&oe=utf-8&as_umsgid=20020722075313.GN1465@niksula.cs.hut.fi&lr=&num=50&hl=en
> 

        The last 2.5 series kernel that had the floppy driver working fine for 
me, was 2.5.7. I want to say it was in 2.5.13 that it was broken. But tread 
warily with anything that early in the tree. there's bound to be a number of 
things that were being broken back then. 2.5.7 was the last in which 
everything that I needed worked for me.

                                                        BL.
-- 
Brad Littlejohn                         | Email:        tyketto@wizard.com
Unix Systems Administrator,             |           tyketto@ozemail.com.au
Web + NewsMaster, BOFH.. Smeghead! :)   |   http://www.wizard.com/~tyketto
  PGP: 1024D/E319F0BF 6980 AAD6 7329 E9E6 D569  F620 C819 199A E319 F0BF

