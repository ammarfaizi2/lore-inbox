Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318849AbSHLWPe>; Mon, 12 Aug 2002 18:15:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318850AbSHLWPe>; Mon, 12 Aug 2002 18:15:34 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:60567
	"EHLO Bill-The-Cat.bloom.county") by vger.kernel.org with ESMTP
	id <S318849AbSHLWPe>; Mon, 12 Aug 2002 18:15:34 -0400
Date: Mon, 12 Aug 2002 15:15:55 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       Greg Banks <gnb@alphalink.com.au>,
       Peter Samuelson <peter@cadcamlab.org>, linux-kernel@vger.kernel.org,
       kbuild-devel@lists.sourceforge.net
Subject: Re: [patch] config language dep_* enhancements
Message-ID: <20020812221555.GF20176@opus.bloom.county>
References: <20020812214032.GD20176@opus.bloom.county> <Pine.LNX.4.44.0208122352440.28515-100000@serv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0208122352440.28515-100000@serv>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 13, 2002 at 12:13:51AM +0200, Roman Zippel wrote:
> Hi,
> 
> On Mon, 12 Aug 2002, Tom Rini wrote:
> 
> > > More examples of the cml1 limitations can be found in arch/ppc/config.in -
> > > a single choice statement needs to be splitted into multiple choice
> > > statements.
> >
> > Er, which are you referring to here?  All of the choice statements are
> > done for clarity here. :)  Tho I was (and have been) pondering creating
> > arch/ppc/platforms/Config-[468]xx.in, which would rather nicely move all
> > of the options related to IBM 4xx processors to one file, Motorola 8xx
> > to another, and general PPC's nicely.
> 
> There is still a bit of overlap. Roughly it's possible to sort the machine
> types by cpu type, but IMO it's not the best solution. I think it would be
> better to sort them by general machine type.

Er, 'general machine type' ?

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
