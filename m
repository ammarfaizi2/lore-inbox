Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261404AbSJUPnz>; Mon, 21 Oct 2002 11:43:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261412AbSJUPnz>; Mon, 21 Oct 2002 11:43:55 -0400
Received: from smtp1.home.se ([195.66.35.200]:39356 "EHLO smtp1.home.se")
	by vger.kernel.org with ESMTP id <S261404AbSJUPny>;
	Mon, 21 Oct 2002 11:43:54 -0400
Message-ID: <009501c27919$7fac8070$0219450a@sandos>
From: =?iso-8859-1?Q?John_B=E4ckstrand?= <sandos@home.se>
To: <linux-kernel@vger.kernel.org>
Subject: Re: Problem with thinkpad 760xl, (Trident FB) TGUI 96xx
Date: Mon, 21 Oct 2002 17:49:53 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have a IBM Thinkpad 760XL, with a trident in it,
> giving this from lspci -v -v:
>
> 00:03.0 VGA compatible controller: Trident
Microsystems
> TGUI 9660/968x/968x (rev d3) (prog-if 00 [VGA])
>         Control: I/O+ Mem+ BusMaster- SpecCycle-
> MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
>         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr-
> DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR-
<PERR-
>         Interrupt: pin A routed to IRQ 11
>         Region 0: Memory at 08000000 (32-bit,
> non-prefetchable) [size=4M]
>         Region 1: Memory at 08400000 (32-bit,
> non-prefetchable) [size=64K]
>         Region 2: Memory at 08800000 (32-bit,
> non-prefetchable) [size=4M]
>         Expansion ROM at 000c0000 [disabled]
[size=64K]
>
> The tridentfb driver isnt working very good, the
output
> on screen is in some way interlaced in some odd way.
I
> have a .png here:

Forgot the link:

http://medlem.spray.se/sandos/thinkpad.jpg

The characters does seem to be solid in this jpeg, but
they have every second scanline black/ displaced.

> I have also not been able to get Xfree 4.2.1 working,
> but that seems to be another problem, seems the
> modeline isnt right. The tridentfb driver seems to be
> more on course, since the screen is atleast stable,
not
> unsycnched "noise" as in X, only weirdly interleaved.
> Any ideas? Is this 760XL in some way different from
> others of the same brand, since others seem to have
> better luck?
>
> ---
> John Bäckstrand
>


