Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261502AbREWKIw>; Wed, 23 May 2001 06:08:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261683AbREWKIm>; Wed, 23 May 2001 06:08:42 -0400
Received: from khan.acc.umu.se ([130.239.18.139]:45050 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id <S261502AbREWKIY>;
	Wed, 23 May 2001 06:08:24 -0400
Date: Wed, 23 May 2001 12:08:21 +0200
From: David Weinehall <tao@acc.umu.se>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.4-ac14
Message-ID: <20010523120821.A3640@khan.acc.umu.se>
In-Reply-To: <Pine.LNX.4.05.10105230915100.16280-100000@callisto.of.borg> <20677.990608858@kao2.melbourne.sgi.com> <20010523053620.C7114@zalem.puupuu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <20010523053620.C7114@zalem.puupuu.org>; from galibert@pobox.com on Wed, May 23, 2001 at 05:36:20AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 23, 2001 at 05:36:20AM -0400, Olivier Galibert wrote:
> On Wed, May 23, 2001 at 07:07:38PM +1000, Keith Owens wrote:
> > On Wed, 23 May 2001 09:17:08 +0200 (CEST), 
> > Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > >On Wed, 23 May 2001, Keith Owens wrote:
> > >> Is drivers/char/ser_a2232fw.ax supposed to be included?  Nothing uses it.
> > >
> > >It's the source for the firmware hexdump in ser_a2232fw.h, provided as a
> > >reference.
> > 
> > What is the point of including it in the kernel source tree without the
> > code to convert it to ser_a2232fw.h?  Nobody can use ser_a2232fw.ax, it
> > is just bloat.
> 
> We don't provide the binutils or gcc with the kernel either.  The 6502
> is a rather well known processor.  Try plonking "6502 assembler" in
> google and you'll have a lot of choice.

Me likee, finally asm in the kernel I can grok.


/Tao of TRIAD aka David Weinehall
  _                                                                 _
 // David Weinehall <tao@acc.umu.se> /> Northern lights wander      \\
//  Project MCA Linux hacker        //  Dance across the winter sky //
\>  http://www.acc.umu.se/~tao/    </   Full colour fire           </
