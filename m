Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267387AbRGLAfe>; Wed, 11 Jul 2001 20:35:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267385AbRGLAfP>; Wed, 11 Jul 2001 20:35:15 -0400
Received: from usc.edu ([128.125.253.136]:27341 "EHLO usc.edu")
	by vger.kernel.org with ESMTP id <S267384AbRGLAfJ>;
	Wed, 11 Jul 2001 20:35:09 -0400
Date: Wed, 11 Jul 2001 17:32:31 -0700 (PDT)
From: Laurent Itti <itti@java.usc.edu>
To: Jeff Golds <jgolds@resilience.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: receive stats null for bond0 in 2.4.6
In-Reply-To: <3B4CF00C.5B62DDBA@resilience.com>
Message-ID: <Pine.SV4.3.96.1010711172900.5481E-100000@java.usc.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff:

> It's always zero because the bonding driver included with the Linux
> kernel is pretty broken.  The comments say that its stats are collected
> from the slaves, but this is untrue.  See the source code at
> http://sourceforge.net/projects/bonding for how the stats should be
> collected.

I'll check the source. Thanks!  Used to work in previous kernels, so I'll
look for changes...

  -- laurent

-----------------------------------------------------------------------
Laurent Itti - University of Southern California, Computer Science Dept
Hedco Neuroscience Building, HNB-30A - Los Angeles, CA 90089-2520 - USA
Email: itti@java.usc.edu  - Tel: +1(213)740-3527 - Fax: +1(213)740-5687
-----------------------------------------------------------------------

