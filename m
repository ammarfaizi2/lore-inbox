Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314398AbSEFMbU>; Mon, 6 May 2002 08:31:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314403AbSEFMbU>; Mon, 6 May 2002 08:31:20 -0400
Received: from wire.cadcamlab.org ([156.26.20.181]:30470 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S314398AbSEFMbT>; Mon, 6 May 2002 08:31:19 -0400
Date: Mon, 6 May 2002 07:31:10 -0500
To: Oliver.Schersand@BASF-IT-Services.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Review: Servercrash with kernel SuSE 2.4.
Message-ID: <20020506123110.GR4049@cadcamlab.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Oliver Schersand]
> The reason for theses crashes where the compaq remote inside and
> compaq health drivers. These drivers are deliverd from compaq. On
> stardup of these agents, they load binary kernel modules, which are
> very version sensitive.  This modules corrupt the virtual memory
> management of the server on heavy load

Translation: you purchased hardware which requires binary-only kernel
modules to provide needed functionality.

> This shows us a main problem of Linux in datacenter environment.

No, it shows us a main problem of Compaq high-availability storage
products in a Linux environment.  If you're going to point fingers,
make sure they're pointed the right direction.

> The companies which sell these hardware deliver not all features of
> these hardware to the community of linux.  There drivers and guarding
> agents are not distributed under GPL.
[...]
> Thank you very much for all the help with this problem

I'm not sure how the linux-kernel list is supposed to help you.  The
development model of open-source drivers and source-only compatibility
(even that being broken from time to time) is well-established.  It's
not going to change.  And Compaq is fully aware of it.  They have
chosen to swim against the current, providing themselves (and
occasionally their customers, as you have seen) with considerable
headaches as a result.  If they are unable to produce high-quality
drivers for the kernels you wish to run, or at least for a list of
kernels they explicitly support, there are other datacenter storage
vendors (and indeed other operating systems) out there.  IBM for
instance makes all the right noises - maybe they have products you can
use.
