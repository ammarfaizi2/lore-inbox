Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281289AbRKZAvU>; Sun, 25 Nov 2001 19:51:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281294AbRKZAvO>; Sun, 25 Nov 2001 19:51:14 -0500
Received: from khan.acc.umu.se ([130.239.18.139]:45205 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id <S281289AbRKZAu5>;
	Sun, 25 Nov 2001 19:50:57 -0500
Date: Mon, 26 Nov 2001 01:50:42 +0100
From: David Weinehall <tao@acc.umu.se>
To: Joel Becker <jlbec@evilplan.org>, Paul Mackerras <paulus@samba.org>,
        Dominik Kubla <kubla@sciobyte.de>, Sven.Riedel@tu-clausthal.de,
        linux-kernel@vger.kernel.org
Subject: Re: Linux and RS/6000 250
Message-ID: <20011126015042.K5770@khan.acc.umu.se>
In-Reply-To: <20011125024652.B26191@moog.heim1.tu-clausthal.de> <Pine.NEB.4.33.0111251427280.1488-100000@www2.scram.de> <20011125144038.C5506@duron.intern.kubla.de> <20011125174742.A5789@moog.heim1.tu-clausthal.de> <20011125181051.D5506@duron.intern.kubla.de> <20011125213316.J7455@parcelfarce.linux.theplanet.co.uk> <15361.27977.474176.551443@cargo.ozlabs.ibm.com> <20011126004048.K7455@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <20011126004048.K7455@parcelfarce.linux.theplanet.co.uk>; from jlbec@evilplan.org on Mon, Nov 26, 2001 at 12:40:49AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2001 at 12:40:49AM +0000, Joel Becker wrote:
> On Mon, Nov 26, 2001 at 09:14:33AM +1100, Paul Mackerras wrote:
> > 
> > MCA is a different story, there is no support for MCA in PPC/Linux.
> 
> 	Interesting.  x86 has supported it for a while?  Was MCA totally
> ripped out, or is it merely a case of no one having the hardware to get
> it working?

MCA still works just fine on x86 (at least my PCServer 500, with
a P90 and 8 MCA-slots runs just fine as a nice "little" firewall),
but afaict knowing how to access the MCA-bus on a PS/2 and how to access
it on an RS/6000 is two completely different things.


/David
  _                                                                 _
 // David Weinehall <tao@acc.umu.se> /> Northern lights wander      \\
//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
\>  http://www.acc.umu.se/~tao/    </   Full colour fire           </
