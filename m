Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277253AbRJIO3Q>; Tue, 9 Oct 2001 10:29:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277256AbRJIO3H>; Tue, 9 Oct 2001 10:29:07 -0400
Received: from [217.141.181.238] ([217.141.181.238]:27227 "HELO hobbes.wired")
	by vger.kernel.org with SMTP id <S277253AbRJIO2y>;
	Tue, 9 Oct 2001 10:28:54 -0400
Content-Type: text/plain;
  charset="iso-8859-1"
From: Fabio Coatti <cova@ferrara.linux.it>
Organization: FerraraLUG
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] again: Re: Athlon kernel crash (i686 works)
Date: Tue, 9 Oct 2001 16:27:46 +0200
X-Mailer: KMail [version 1.3]
In-Reply-To: <LAW2-OE3760Ov0Hvk1w000079df@hotmail.com> <140103605516.20011009134517@port.imtp.ilyichevsk.odessa.ua>
In-Reply-To: <140103605516.20011009134517@port.imtp.ilyichevsk.odessa.ua>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20011009142746.49C1C9856E@hobbes.wired>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Il 13:45, martedì 9 ottobre 2001, VDA ha scritto:

> Anybody still insist that 'Athlon bug' patch is not to be
> included into mainstream kernel?
> If someone doesn't like it, feel free to make it a config
> option (enabled by default!) and submit an updated patch.
> My original patch against 2.4.9 is at the end.
>
> Tuesday, October 09, 2001, 11:32:24 AM,
> "Marco Berizzi" <pupilla@hotmail.com> wrote:
> MB> I updated my motherboard from ASUS A7V to ABIT KT7A (VIA Apollo KT133A
> MB> chipset). The kernel I had (2.4.10) started crashing on boot  usually
> MB> right after starting init. I tryed a i686 kernel and noticed it works
> MB> OK, so I recompiled my crashy kernel only switching the processor type
> MB> and it also worked. Changed it back to Athlon/K7/Duron and it starts
> MB> crashing.

Same problem here (oops at boot, athlon 1.2GHz, kernels 2.4.9 ->10, athlon 
optimization. All goes right if I set i686 processor) but the patch didn't 
work. I have a GA-7VMM / VIA KLE 133 AGPset Motherboard. The kernel still 
oopses , it only changes color:) (white on black without patch, green on 
black with patch applied.)
I will be happy to test any new patch, if this can help.
--
Fabio Coatti
Ferrara Linux User Group
