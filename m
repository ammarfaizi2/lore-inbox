Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129257AbQK2CzY>; Tue, 28 Nov 2000 21:55:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129340AbQK2CzO>; Tue, 28 Nov 2000 21:55:14 -0500
Received: from pixar.pixar.com ([138.72.10.20]:8105 "EHLO pixar.pixar.com")
        by vger.kernel.org with ESMTP id <S129257AbQK2CzE>;
        Tue, 28 Nov 2000 21:55:04 -0500
Date: Tue, 28 Nov 2000 18:24:58 -0800 (PST)
From: Kiril Vidimce <vkire@pixar.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Dan Hollis <goemon@anime.net>,
        Petter Sundlöf <odd@findus.dhs.org>,
        linux-kernel@vger.kernel.org
Subject: Re: XFree 4.0.1/NVIDIA 0.9-5/2.4.0-testX/11 woes [solved]
In-Reply-To: <E140wft-0005Mx-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.21.0011281822040.1353-100000@nevena.pixar.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Nov 2000, Alan Cox wrote:
> > On Tue, 28 Nov 2000, Dan Hollis wrote:
> > > Dont forget the nvidia driver is completely SMP broken. As in, trash your
> > > filesystems broken.
> > 
> > Not true. It works for us with no problems on a number of SMP boxes 
> > running 2.2.{14,16}. I don't know about 2.4.x.
> 
> Dan is not the only one to report it totally trashing a machine and file systems
> SMP. So I suspect there is something there , but I don't know what (or care).
> I've seen other demos of bugs in the nv driver, long standing ones and
> reading the mangled code you can see bugs even in their mangled code
> without looking too hard.

I've never seen such thing as code without bugs. In my experience,
the NVIDIA drivers are by far the most complete and solid 3D drivers 
under Linux.

KV
--
  ___________________________________________________________________
  Studio Tools                                        vkire@pixar.com
  Pixar Animation Studios                        http://www.pixar.com/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
