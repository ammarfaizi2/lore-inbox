Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277782AbRJIPht>; Tue, 9 Oct 2001 11:37:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277780AbRJIPha>; Tue, 9 Oct 2001 11:37:30 -0400
Received: from law2-oe70.hotmail.com ([216.32.180.163]:51473 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S277778AbRJIPhY>;
	Tue, 9 Oct 2001 11:37:24 -0400
X-Originating-IP: [213.82.66.51]
From: "Marco Berizzi" <pupilla@hotmail.com>
To: "Marek Mentel" <mmark@koala.ichpw.zabrze.pl>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <200110091151.f99BpC520171@koala.ichpw.zabrze.pl>
Subject: Re: Athlon kernel crash (i686 works)
Date: Tue, 9 Oct 2001 17:38:07 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Message-ID: <LAW2-OE701qfT7eEmP9000079f4@hotmail.com>
X-OriginalArrivalTime: 09 Oct 2001 15:37:49.0360 (UTC) FILETIME=[59D87300:01C150D8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

thanks everybody for the response.

Last: my abit is KT7A series v1.3. Does anybody if it is safe to patch
bios with revision ZT?

----- Original Message -----
From: "Marek Mentel" <mmark@koala.ichpw.zabrze.pl>
To: "Marco Berizzi" <pupilla@hotmail.com>
Sent: Tuesday, October 09, 2001 7:38 PM
Subject: Re: Athlon kernel crash (i686 works)


> On Tue, 9 Oct 2001 11:32:24 +0200, Marco Berizzi wrote:
>
> >
> >I also search the mailing list. My mother board is KT7A series v1.3
with
> >bios revision 4T (I also try with 3N, same results). K7 at 1333MHz.
BIOS
> >settings are default (except I have disabled all BIOS/video shadow).
> >After flash I also reset CMOS via hardware jumper.
> >
> >Is there any solution to this (except compiling kernel for 6x86)?
> >
>
>  Try  ZT  bios - it works ok with my ABIT KT7E - with Athlon
> optimised kernels.
>   Using 686 optimised kernels  is not full solution -   user-space
> programs
>   compiled with Atlhon optimisation can  not only crash but  kill
> sytem
>   too ( as far as I remember from  previous linux-kernel posts. )
>
>  Not being kernel developer I must ask you to read   archive messages
>
>  on this topics -   groups.google.com could be helpful .
>
>
> ----------------------------------------------------------------------
> --------------------------------
> Official BIOS release ZT for KT7/KT7-RAID/KT7A/KT7A-RAID/KT7E
>
>
> ftp://ftp.abit.com.tw/pub/bios/kt7
>
> Release information:
>
> 1. Adds three new options to enhance the system compatibility
>
>      .Delay transaction
>      .PCI master read caching
>      .PCI master time-out
>
>    Set above options to Disabled/Disabled/0 may help SB Live 5.1
> sound
>    issue. If the system experiences low performance after these
> settings,
>    enable the "PCI master read caching" please.
> 2. Fixes the issue Athlon 1.3G(100) wrongfully recognized as
> 104x12.5.
> 3. Adds an option "State after power failure".
> 4. Set all four IDE devices to "AUTO".
> 5. Set the default year to 2001.
> 6. BIOS compile date: 05/11/2001
>
>
>
> --------------------------------------------------------
>  Marek Mentel  mmark@koala.ichpw.zabrze.pl  2:484/3.8
>  INSTITUTE FOR CHEMICAL PROCESSING OF COAL , Zabrze , POLAND
>  NOTE: my opinions are strictly my own and not those of my employer
>
>
>
>
