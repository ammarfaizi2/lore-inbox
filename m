Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129477AbQK2Cbv>; Tue, 28 Nov 2000 21:31:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129703AbQK2Cbl>; Tue, 28 Nov 2000 21:31:41 -0500
Received: from pixar.pixar.com ([138.72.10.20]:25510 "EHLO pixar.pixar.com")
        by vger.kernel.org with ESMTP id <S129477AbQK2Cbc>;
        Tue, 28 Nov 2000 21:31:32 -0500
Date: Tue, 28 Nov 2000 18:01:25 -0800 (PST)
From: Kiril Vidimce <vkire@pixar.com>
To: Dan Hollis <goemon@anime.net>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Petter Sundlöf <odd@findus.dhs.org>,
        linux-kernel@vger.kernel.org
Subject: Re: XFree 4.0.1/NVIDIA 0.9-5/2.4.0-testX/11 woes [solved]
In-Reply-To: <Pine.LNX.4.30.0011281639180.27174-100000@anime.net>
Message-ID: <Pine.LNX.4.21.0011281758230.1353-100000@nevena.pixar.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Nov 2000, Dan Hollis wrote:
> Dont forget the nvidia driver is completely SMP broken. As in, trash your
> filesystems broken.

Not true. It works for us with no problems on a number of SMP boxes 
running 2.2.{14,16}. I don't know about 2.4.x.

KV
--
  ___________________________________________________________________
  Studio Tools                                        vkire@pixar.com
  Pixar Animation Studios                        http://www.pixar.com/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
