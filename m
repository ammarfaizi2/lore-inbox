Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291348AbSBXV16>; Sun, 24 Feb 2002 16:27:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291355AbSBXV1t>; Sun, 24 Feb 2002 16:27:49 -0500
Received: from ns.snowman.net ([63.80.4.34]:1294 "EHLO ns.snowman.net")
	by vger.kernel.org with ESMTP id <S291348AbSBXV1i>;
	Sun, 24 Feb 2002 16:27:38 -0500
Date: Sun, 24 Feb 2002 16:25:28 -0500 (EST)
From: <nick@snowman.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Martin Dalecki <dalecki@evision-ventures.com>,
        Troy Benjegerdes <hozer@drgw.net>,
        Linus Torvalds <torvalds@transmeta.com>,
        Andre Hedrick <andre@linuxdiskcert.org>,
        Rik van Riel <riel@conectiva.com.br>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Flash Back -- kernel 2.1.111
In-Reply-To: <E16f6F7-0002kv-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.21.0202241624330.10803-100000@ns>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

None of the chipsets that supported VLB had more than one buss.  What I
don't know is some idiot may have built a VLB-VLB bridge, but I doubt it.
	Nick

On Sun, 24 Feb 2002, Alan Cox wrote:

> > (Do you remmeber about 4 years ago there *was* already a lengthy
> > discussion about bus speed detection, without any proper resolution at
> > all...I remember myself having even provided some code for this
> > purpose...which was basicually just measuring RAM transfer rates...)
> 
> I guess we register an isa and a vlb bus - anyone have two vlb busses ?
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

