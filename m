Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288058AbSBIBqn>; Fri, 8 Feb 2002 20:46:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288061AbSBIBqb>; Fri, 8 Feb 2002 20:46:31 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:53469 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S288058AbSBIBqT>;
	Fri, 8 Feb 2002 20:46:19 -0500
Date: Fri, 8 Feb 2002 20:46:18 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Skip Ford <skip.ford@verizon.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: de_put: entry sys already free!
In-Reply-To: <20020209014147.QRFC379.out019.verizon.net@pool-141-150-235-204.delv.east.verizon.net>
Message-ID: <Pine.GSO.4.21.0202082045530.28514-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 8 Feb 2002, Skip Ford wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Alexander Viro wrote:
> > 
> > Fix already merged and no, it's not quite harmless.
> 
> Thanks for the patch...and how do I fix any damage it caused if it's not
> harmless?  It sure didn't seem to cause any.

In principle - memory corruption is possible.

