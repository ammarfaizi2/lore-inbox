Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261682AbSJAOKD>; Tue, 1 Oct 2002 10:10:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261692AbSJAOKD>; Tue, 1 Oct 2002 10:10:03 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:57763 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S261682AbSJAOKC>;
	Tue, 1 Oct 2002 10:10:02 -0400
Date: Tue, 1 Oct 2002 10:15:26 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Joe Thornber <joe@fib011235813.fsnet.co.uk>
cc: linux-kernel@vger.kernel.org, Dave Jones <davej@suse.de>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] Remove LVM from 2.5 (resend)
In-Reply-To: <20021001140639.GA25624@fib011235813.fsnet.co.uk>
Message-ID: <Pine.GSO.4.21.0210011010380.4135-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 1 Oct 2002, Joe Thornber wrote:

> bk://device-mapper.bkbits.net/2.5-remove-lvm
> 
> This large patch completely removes LVM from the 2.5 tree.  Please
> apply.  Yes it really has spread as far as linux/list.h and
> linux/kdev_t.h !

Seconded - LVM in the tree is thoroughly dead.

Speaking of which, would Intermezzo maintainers care to port the thing
to 2.5?  If it's abandoned - at least say so ;-/

