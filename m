Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318835AbSHLVhP>; Mon, 12 Aug 2002 17:37:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318838AbSHLVhP>; Mon, 12 Aug 2002 17:37:15 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:50839
	"EHLO Bill-The-Cat.bloom.county") by vger.kernel.org with ESMTP
	id <S318835AbSHLVhO>; Mon, 12 Aug 2002 17:37:14 -0400
Date: Mon, 12 Aug 2002 14:40:32 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       Greg Banks <gnb@alphalink.com.au>,
       Peter Samuelson <peter@cadcamlab.org>, linux-kernel@vger.kernel.org,
       kbuild-devel@lists.sourceforge.net
Subject: Re: [kbuild-devel] Re: [patch] config language dep_* enhancements
Message-ID: <20020812214032.GD20176@opus.bloom.county>
References: <Pine.LNX.4.44.0208120924320.5882-100000@chaos.physics.uiowa.edu> <Pine.LNX.4.44.0208121959360.8911-100000@serv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0208121959360.8911-100000@serv>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 12, 2002 at 09:45:37PM +0200, Roman Zippel wrote:

> More examples of the cml1 limitations can be found in arch/ppc/config.in -
> a single choice statement needs to be splitted into multiple choice
> statements.

Er, which are you referring to here?  All of the choice statements are
done for clarity here. :)  Tho I was (and have been) pondering creating
arch/ppc/platforms/Config-[468]xx.in, which would rather nicely move all
of the options related to IBM 4xx processors to one file, Motorola 8xx
to another, and general PPC's nicely.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
