Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280804AbRKGOkP>; Wed, 7 Nov 2001 09:40:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280801AbRKGOkE>; Wed, 7 Nov 2001 09:40:04 -0500
Received: from mailer.zib.de ([130.73.108.11]:27290 "EHLO mailer.zib.de")
	by vger.kernel.org with ESMTP id <S280804AbRKGOju>;
	Wed, 7 Nov 2001 09:39:50 -0500
Date: Wed, 7 Nov 2001 15:39:46 +0100
From: Sebastian Heidl <heidl@zib.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Intel compiler [Re: Using %cr2 to reference "current"]
Message-ID: <20011107153946.T552@csr-pc1.zib.de>
In-Reply-To: <3BE94C55.AE42D67E@evision-ventures.com> <E161TWH-0004G9-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E161TWH-0004G9-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Wed, Nov 07, 2001 at 02:17:33PM +0000
X-www.distributed.net: 27 OGR packets (3.56 Tnodes) [4.21 Mnodes/s]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 07, 2001 at 02:17:33PM +0000, Alan Cox wrote:
> > somehow encouraged by the compiler comparisions between gcc and intel's
> > free compiler, which use the register passing for anything local
> > to the actual code, where the speed gains are up to 20% im currently
> 
> I was under the impression intels compiler was profoundly non-free ?

have a look:
http://developer.intel.com/software/products/eval/


_sh_

