Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266772AbTBQE6S>; Sun, 16 Feb 2003 23:58:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266796AbTBQE6S>; Sun, 16 Feb 2003 23:58:18 -0500
Received: from csa.iisc.ernet.in ([144.16.67.8]:29916 "EHLO csa.iisc.ernet.in")
	by vger.kernel.org with ESMTP id <S266772AbTBQE6O>;
	Sun, 16 Feb 2003 23:58:14 -0500
Date: Mon, 17 Feb 2003 10:38:05 +0530 (IST)
From: Rahul Vaidya <rahulv@csa.iisc.ernet.in>
Reply-To: Rahul Vaidya <rahulv@csa.iisc.ernet.in>
To: Daniel Jacobowitz <dan@debian.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: linux 2.5.53 not compiling
In-Reply-To: <20030217040949.GA10986@nevyn.them.org>
Message-ID: <Pine.SOL.3.96.1030217102959.28131E-100000@osiris.csa.iisc.ernet.in>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you Daniel,

                The kernel source compiled. I changed the CC variable
path.

I also thank Russel,Zwane and John for their help.

Thanks again.  

--
Rahul Vaidya
Hostel Room G46,
Ph.3942451

"Life can only be understood going backwards, 
	            but it must be lived going forwards"
						-Kierkegaard

On Sun, 16 Feb 2003, Daniel Jacobowitz wrote:

> On Mon, Feb 17, 2003 at 09:33:32AM +0530, Rahul Vaidya wrote:
> > >From my kernel source directory: I have aliased gcc to my actual gcc
> > file..not the softlinked one..
> 
> Shell aliases won't affect the GCC that Make uses.  Try using make
> CC=/path/to/real/gcc.
> 
> -- 
> Daniel Jacobowitz
> MontaVista Software                         Debian GNU/Linux Developer
> 



