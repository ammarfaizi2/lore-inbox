Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132677AbRDGQoj>; Sat, 7 Apr 2001 12:44:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132680AbRDGQoa>; Sat, 7 Apr 2001 12:44:30 -0400
Received: from anatpc.mystery.local ([194.44.62.155]:3457 "EHLO
	lena.mystery.lviv.ua") by vger.kernel.org with ESMTP
	id <S132677AbRDGQoW>; Sat, 7 Apr 2001 12:44:22 -0400
Date: Sat, 7 Apr 2001 19:42:26 +0300
From: "Volodymyr M . Lisivka" <lvm_ukr@yahoo.com>
To: green@linuxhacker.ru, Kernel mailing list <linux-kernel@vger.kernel.org>
Cc: "Volodymyr M . Lisivka" <lvm_ukr@yahoo.com>
Subject: Re: NLS: koi8-u support
Message-ID: <20010407194226.A19933@lena.lviv.ua>
In-Reply-To: <20010406192303.A11680@lena.lviv.ua> <200104061921.f36JLZH16688@morgoth.ixcelerator.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: =?KOI8-U?Q?=3C200104061921=2Ef36JLZH16688=40morgoth=2Eixcelerator=2Ecom?=
 =?KOI8-U?Q?=3E=3B_from_green=40linuxhacker=2Eru_on_=F0=D4=CE=2C_=EB=D7?=
 =?KOI8-U?Q?=A6_06=2C_2001_at_22:21:35_+0300?=
X-Mailer: Balsa 1.1.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2001.04.06 22:21:35 +0300 green@linuxhacker.ru wrote:
> Hello!
> 
>   It was added already. But charset name is koi8-ru for
>   some strange reason

Sound good.

koi8-ru  extends koi8-u(RFC-2319) only by one Byelorussian letter.
But standartization of koi8-ru is not finished at this moment and these
encodings have different codes for some special symbols (AFAIK).
(See details on http://www.cad.ntu-kpi.kiev.ua/multiling/
and http://www.net.ua/KOI8-U/ )

Maybe it would be better to separate supporting of koi8-u and koi8-ru in
kernel
to avoid problems in future?

> Bye,
>     Oleg
> In article <20010406192303.A11680@lena.lviv.ua> you wrote:
> > Please add support of KOI-8 Ukrainian (AKA koi8-u) encoding into
> kernel,
> > because
> > ukrainian users can't read files with ukrainian names from NTFS and SMB
> > disks without it.
> 
> > Patch for 2.4.x kernels (2.4.0-test10 - 2.4.3):
> > ==========cut from here================

-- 
Best regards,                   mailto:lvm_ukr@yahoo.com
Volodymyr M. Lisivka            ICQ#14549856

