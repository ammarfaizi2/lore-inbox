Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129942AbQKAXmf>; Wed, 1 Nov 2000 18:42:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131854AbQKAXmY>; Wed, 1 Nov 2000 18:42:24 -0500
Received: from hybrid-024-221-152-185.az.sprintbbd.net ([24.221.152.185]:52212
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S131932AbQKAXmI>; Wed, 1 Nov 2000 18:42:08 -0500
Date: Wed, 1 Nov 2000 16:36:59 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Where did kgcc go in 2.4.0-test10 ?
Message-ID: <20001101163659.D32641@opus.bloom.county>
In-Reply-To: <20001101162108.C32641@opus.bloom.county> <E13r7LH-0000z2-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E13r7LH-0000z2-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Wed, Nov 01, 2000 at 11:30:50PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 01, 2000 at 11:30:50PM +0000, Alan Cox wrote:
> > Yes, but what's more important is that all of these "kgcc" variants are
> > gcc 2.7.2.x-based (unless there's one I don't know about).  And we don't want
> > 2.7.2.x, we want egcs 1.1.2 or newer (but not gcc 2.9x, unless you know what
> > you're doing and are trying to fix the compiler. :)).
> 
> Conectiva kgcc is egcs 1.1.2
> Red Hat kgcc is egcs 1.1.2
> Mandrake kgcc I believe is egcs 1.1.2

heh, ok.  i'm wrong. :)

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
