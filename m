Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261511AbSJ2Cpx>; Mon, 28 Oct 2002 21:45:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261514AbSJ2Cpx>; Mon, 28 Oct 2002 21:45:53 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:27144 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S261511AbSJ2Cpw>;
	Mon, 28 Oct 2002 21:45:52 -0500
Message-ID: <3DBDF7C4.4050408@pobox.com>
Date: Mon, 28 Oct 2002 21:51:48 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo@conectiva.com.br>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, netdev@oss.sgi.com,
       LKML <linux-kernel@vger.kernel.org>
Subject: [BK/GNU] net driver series 13
Content-Type: multipart/mixed;
 boundary="------------090203010605090204080202"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090203010605090204080202
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit



--------------090203010605090204080202
Content-Type: text/plain;
 name="net-drivers-2.4.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="net-drivers-2.4.txt"

Marcelo, please do a

	bk pull http://gkernel.bkbits.net/net-drivers-2.4

This will update the following files:

 drivers/net/pcmcia/fmvj18x_cs.c |    5 ++---
 drivers/net/tulip/tulip_core.c  |    1 +
 2 files changed, 3 insertions(+), 3 deletions(-)

through these ChangeSets:

<alan@lxorguk.ukuu.org.uk> (02/10/28 1.770)
   del_timer_sync fixes for fmvj18x_cs net driver

<komujun@nifty.com> (02/10/28 1.769)
   Add PCI id to tulip net driver


--------------090203010605090204080202
Content-Type: application/x-bzip2;
 name="netdrvr-13.tar.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="netdrvr-13.tar.bz2"

QlpoOTFBWSZTWYfquIkAA3D/hOiwAgBZf//7f6/fZP//3/oABBAIUAOZ5jaodtAUGRKaE2po
2ozU0wJiZMJ6m0TamjEyaAyNMmmTTDKpo0PSNAAAAAAGgAAAAABJEBE9QU9TanhRpoaNAANM
1GmgADQDagcZMmjQGjTEZGhiGBNGmIMRoMIADBJFCaaYJqnk9GiMak2poxNA0BhGg09QZpGm
J7lPazZnNMl/hCnRIEatVIQKMKLs9oSFIWNAwkmTrQ7Z3Pjb0hl3JJmCbBs6G6buzNDoyDrt
AcbOdIx4sENxtwnlaogILStRAsolrZ1OmSWPDWES4T7HQHHvb+zSHBYoyorEohjAJmYNF4aQ
MIR5dMcxqW1sjrCDM5pAVgJtypmtEkTaKJxMH4yjr744w8IhSooYGl47A5j7+pnXVdv9QrAb
ggCh4TAHXeRp8bF5UEXL95XEiYuCMqaoG25BpAIGHuJ6CYCXsggVy+0TDJfhM8FVrLKrSdrL
UCYYMKNKZUBjembTphmZu92+dTzd3XiKja1jDDImA4rp5gOEI6ip0HFAJSwQnW6B2QXIIhs5
JE/mTVAqScs54QgbZNN79u1LhKkOzncvlY2k0RnolIML42iaVM59KLzxnYgYIYgn3ByGQOHB
2IBEtkIBDDvjq6CrV1CL3gZngRg9GzhFXTnKI8zQpK6+Kx8FTJ8rjEXikNMGqVtKiinkMtQt
8pBirA9TLbO0pQJILYLV+lNMMqOoXheGteXW64jQZw9QnXgUzAWx8X6EqeNukfaEHEmREYEl
6vNvkOYUAohGN9UDQM1GwSVBMwJEnAEOK6qOhFYN0clIYxLqMpMlfIkgwah/BJAGqU3p5IjT
pdr0IlO8S/E/yJSIcAbgHD5/RBjlWNSwhyhPeOqufLkeS6uQ7TnFqkVtRGShzGMCg/kR0hGE
WdIzBd9TGxPpgMVDTePzkhEcwESyjHscsHTODeRxwaNMtRhjYcDNCYgWRgeMwBmKHGKA1FWe
SIuPJzistsxRU5y8RuD5pmaom7hZcStsSnGQTuIrxoL67Fg2BNeJxPS74VR0G2QK7x2axjVI
gycnSbISJ8KBg7a78i/ZmC0CbvfrmlodKRjGFFNHV7QzxRB5d22O8gpFMaDKVqp7UygCAKzP
i7jSbdwtIBE2GUD0kVYUM3cGDSAxEIlVY5uIjMGBTqhhwYeFUlF8MADR0zk9uvgyWNtIN+Uy
QfFu9bVJiESoKVYcXwQv0ga5t1TZCQV9aAGSqEl/xdyRThQkIfquIkA=
--------------090203010605090204080202--

