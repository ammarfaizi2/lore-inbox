Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129860AbQK1ND3>; Tue, 28 Nov 2000 08:03:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130006AbQK1NDJ>; Tue, 28 Nov 2000 08:03:09 -0500
Received: from c008-h019.c008.sfo.cp.net ([209.228.14.208]:3722 "HELO
        c008.sfo.cp.net") by vger.kernel.org with SMTP id <S129860AbQK1NDC>;
        Tue, 28 Nov 2000 08:03:02 -0500
X-Sent: 28 Nov 2000 12:32:54 GMT
Message-ID: <3A23A5F4.CF20D52D@rouvier.net>
Date: Tue, 28 Nov 2000 04:32:52 -0800
From: Joe Rouvier <joe@rouvier.net>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: reneb@cistron.nl, linux-kernel@vger.kernel.org
Subject: Re: Trident sound does not work anymore!
In-Reply-To: <slrn927896.59.reneb@orac.aais.nl> <3A2395DD.70674662@rouvier.net>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At least, that worked for me.  I had this same problem on 2.2.17 with my
es1371 when I bought a new ASUS P3V4X motherboard.  If someone has a
better solution I'd love to hear about it!

Joe Rouvier wrote:
> 
> Try setting "PNP aware OS" (or something like that) to "NO" in your
> BIOS.
> 
> Rene Blokland wrote:
> >
> > Hi there, as the subject says the trident sound does not work since
> > 2.4.0-test9. this messages does dmesg:
> > Trident 4DWave/SiS 7018/ALi 5451 PCI Audio, version 0.14.6, 12:36:52 Nov 20 2000
> > trident: Trident 4DWave DX found at IO 0xd800, IRQ 0
> > trident: unable to allocate irq 0
> > any ideas?
> >
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > Please read the FAQ at http://www.tux.org/lkml/
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
