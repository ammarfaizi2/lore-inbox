Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130308AbRBZP5O>; Mon, 26 Feb 2001 10:57:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130307AbRBZP5F>; Mon, 26 Feb 2001 10:57:05 -0500
Received: from mrelay.cc.umr.edu ([131.151.1.89]:37646 "EHLO smtp.umr.edu")
	by vger.kernel.org with ESMTP id <S130248AbRBZP4y>;
	Mon, 26 Feb 2001 10:56:54 -0500
Date: Mon, 26 Feb 2001 09:56:21 -0600
From: David Fries <dfries@umr.edu>
To: Lennert Buytenhek <buytenh@math.leidenuniv.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Stale NFS handles on 2.4.2
Message-ID: <20010226095621.F483@d-131-151-189-65.dynamic.umr.edu>
In-Reply-To: <shsvgpyual0.fsf@charged.uio.no> <Pine.LNX.4.30.0102261052520.16700-100000@page.math.leidenuniv.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.30.0102261052520.16700-100000@page.math.leidenuniv.nl>; from buytenh@math.leidenuniv.nl on Mon, Feb 26, 2001 at 10:54:02AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 26, 2001 at 10:54:02AM +0100, Lennert Buytenhek wrote:
> A trick that works for me is mounting the NFS filesystem on another mount
> point and unmounting it there. This usually makes the mount on the
> original mount point magically work again.

Thinks, but I've tried it and it didn't work already.

-- 
		+---------------------------------+
		|      David Fries                |
		|      dfries@umr.edu             |
		+---------------------------------+
