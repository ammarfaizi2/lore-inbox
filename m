Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288953AbSANTlE>; Mon, 14 Jan 2002 14:41:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288926AbSANTjs>; Mon, 14 Jan 2002 14:39:48 -0500
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:54146
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S288996AbSANTaW>; Mon, 14 Jan 2002 14:30:22 -0500
Date: Mon, 14 Jan 2002 12:29:34 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "Eric S. Raymond" <esr@thyrsus.com>,
        Charles Cazabon <charlesc@discworld.dyndns.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Eli Carter <eli.carter@inet.com>,
        "Michael Lazarou (ETL)" <Michael.Lazarou@etl.ericsson.se>
Subject: Re: Aunt Tillie builds a kernel (was Re: ISA hardware discovery -- the elegant solution)
Message-ID: <20020114192934.GA3298@cpe-24-221-152-185.az.sprintbbd.net>
In-Reply-To: <20020114125228.B14747@thyrsus.com> <E16QBwD-0002So-00@the-village.bc.nu> <20020114132618.G14747@thyrsus.com> <20020114125508.A3358@twoflower.internal.do> <20020114135412.D17522@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020114135412.D17522@thyrsus.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2002 at 01:54:12PM -0500, Eric S. Raymond wrote:
> Charles Cazabon <charlesc@discworld.dyndns.org>:
> > Yes, and yes.  Aunt Tillie is running Linux because someone installed a
> > distribution for her.
> 
> You don't know that.  Maybe she installed it herself.

So she installed it herself, why isn't $distrovender kernel good enough?
Keep in mind that just because $kernelversion has a bug doesn't mean
that $distrovender-$kernelversion does.  So yes, relying on an update
from $distrovendor is a good thing.  What if your automagic tool existed
and Aunt Tillie clicked when 2.4.15 was current stable?

> > She is never going to need anything out of her kernel that her vendor-shipped
> > update kernels do not provide.
> 
> *You can't know that.*  

Would you accept She'll almost never need something thats not in her
current $distrovednor kernel or the one $distrovendor is working on?

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
