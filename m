Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281072AbRKYVdk>; Sun, 25 Nov 2001 16:33:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281075AbRKYVdb>; Sun, 25 Nov 2001 16:33:31 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:31241 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S281072AbRKYVdU>;
	Sun, 25 Nov 2001 16:33:20 -0500
Date: Sun, 25 Nov 2001 21:33:16 +0000
From: Joel Becker <jlbec@evilplan.org>
To: Dominik Kubla <kubla@sciobyte.de>
Cc: Sven.Riedel@tu-clausthal.de, linux-kernel@vger.kernel.org
Subject: Re: Linux and RS/6000 250
Message-ID: <20011125213316.J7455@parcelfarce.linux.theplanet.co.uk>
Mail-Followup-To: Joel Becker <jlbec@evilplan.org>,
	Dominik Kubla <kubla@sciobyte.de>, Sven.Riedel@tu-clausthal.de,
	linux-kernel@vger.kernel.org
In-Reply-To: <20011125024652.B26191@moog.heim1.tu-clausthal.de> <Pine.NEB.4.33.0111251427280.1488-100000@www2.scram.de> <20011125144038.C5506@duron.intern.kubla.de> <20011125174742.A5789@moog.heim1.tu-clausthal.de> <20011125181051.D5506@duron.intern.kubla.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011125181051.D5506@duron.intern.kubla.de>; from kubla@sciobyte.de on Sun, Nov 25, 2001 at 06:10:51PM +0100
X-Burt-Line: Trees are cool.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 25, 2001 at 06:10:51PM +0100, Dominik Kubla wrote:
> On Sun, Nov 25, 2001 at 05:47:42PM +0100, Sven.Riedel@tu-clausthal.de wrote:
> > On Sun, Nov 25, 2001 at 02:40:38PM +0100, Dominik Kubla wrote:
> > > Add a 350 from me.  But the problem is not just the PPC/MCA combination,
> > > but also the CPU. It's Power, not PowerPC!
> > 
> > Really? The IBM website says the following:
> > 
> > <quote>
> > The IBM* RS/6000 Model 250 is flexible and powerful, and performs well
> > as either a graphics workstation or a server. Driven by a 66MHz PowerPC
> > 601* microprocessor,[...]
> > </quote>
> ...
> > Marketing strikes again, eh? :/
> 
> No, i screwed up. The 250 and the 43P user PowerPC...

The 7011-250 uses a PowerPC 601, which may or may not be happy with
arch/ppc.  The 7248 (PReP-based 43P) uses a PowerPC 604 and should run
fine.  The 7043 (CHRP-based 43P) uses a PowerPC 604e and should also run
fine.

Joel


-- 

"But all my words come back to me
 In shades of mediocrity.
 Like emptiness in harmony
 I need someone to comfort me."

			http://www.jlbec.org/
			jlbec@evilplan.org
