Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281006AbRKTJwd>; Tue, 20 Nov 2001 04:52:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281005AbRKTJwY>; Tue, 20 Nov 2001 04:52:24 -0500
Received: from khan.acc.umu.se ([130.239.18.139]:48360 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id <S281004AbRKTJwM>;
	Tue, 20 Nov 2001 04:52:12 -0500
Date: Tue, 20 Nov 2001 10:52:10 +0100
From: David Weinehall <tao@acc.umu.se>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] reformat mtrr.c to conform to CodingStyle
Message-ID: <20011120105210.A6116@khan.acc.umu.se>
In-Reply-To: <20011112232539.A14409@redhat.com> <20011113121022.L1778@lynx.no> <20011114085714.V17761@khan.acc.umu.se> <20011120214703.A26799@mail.wave.co.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <20011120214703.A26799@mail.wave.co.nz>; from markv@wave.co.nz on Tue, Nov 20, 2001 at 09:47:04PM +1300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2001 at 09:47:04PM +1300, Mark van Walraven wrote:
> On Wed, Nov 14, 2001 at 08:57:14AM +0100, David Weinehall wrote:
> > 	switch (option) {
> > 	case 1: 
> > 		/* blaha */
> > 
> > 
> > That feels kind of odd compared to the rest of the codingstyle.
> > 
> > Comments?!
> 
> A case statement is a label, therefore "outdented" on level.

Makes sense, I guess.


/David
  _                                                                 _
 // David Weinehall <tao@acc.umu.se> /> Northern lights wander      \\
//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
\>  http://www.acc.umu.se/~tao/    </   Full colour fire           </
