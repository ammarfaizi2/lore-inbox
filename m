Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272181AbRI0JEN>; Thu, 27 Sep 2001 05:04:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272212AbRI0JEE>; Thu, 27 Sep 2001 05:04:04 -0400
Received: from [213.236.192.200] ([213.236.192.200]:26571 "EHLO
	mail.circlestorm.org") by vger.kernel.org with ESMTP
	id <S272181AbRI0JDn>; Thu, 27 Sep 2001 05:03:43 -0400
Message-ID: <005401c14733$9c6c1e00$0a00000a@dead2>
From: "Dead2" <dead2@circlestorm.org>
To: "Jordan Breeding" <ledzep37@home.com>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
In-Reply-To: <009b01c1469f$cc704a20$d2c0ecd5@dead2> <3BB23E0C.B7F708E0@home.com> <3BB27774.4FA630A2@home.com>
Subject: Re: Asus CUV266-D problems
Date: Thu, 27 Sep 2001 11:05:52 +0200
Organization: CircleStorm Productions
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The CUV266-D is indeed in wide production, and i bought it from
www.komplett.no Unfortunately that site is here in Norway.
I am sure several international sites sell it aswell.
http://www.komplett.no/k/k.asp?action=info&p=15140&l=2&AvdID=1&CatID=10&GrpI
D=6&s=pl

The CUV266-DLS is also available from that page, and they even
have them in stock..
http://www.komplett.no/k/k.asp?action=info&p=16520&l=2&AvdID=1&CatID=10&GrpI
D=6&s=pl

When I'm looking at the lspci -v output, i keep wondering why two
of the chips read "Unknown device 8064".. Shouldn't this be fixed
by a kernel maintainer?

I'll send you the .config tomorrow, and I'll test the 1004 bios version then
too, as i'm not at work today.. =/

 - Hans K. aka Dead2

----- Original Message -----
From: "Jordan Breeding" <ledzep37@home.com>
> Sorry to bother you again so quickly, do you know if this board is in
> wide production yet, specifically the CUV266-DLS?  Did you have to buy
> yours or did you get a testing copy, if you had to buy yours do you mind
> my asking where you got it?  Also if you wouldn't mind sending me your
> .config from your 2.4.10 kernel I would like to check some options to do
> with your problem.  Thanks.
>
> Jordan
>
> Jordan Breeding wrote:
> >
> > Sorry I can't provide any help about the CUV266-D, however I have been
> > waiting for some time for this board to come out.  I have a Tyan Tiger
> > 230 currently but wanted a 266 chipset and also onboard scsi.  I didn't
> > really feel completely comfortable with the LSI chipset on the
> > CUV4X-DLS, so I was very glad to hear that the DLS version of the CUV266
> > is supposed to have an Adaptec SCSI chipset.  Do you know where I can
> > find any further information on either of the boards, the CUV266-D or
> > the DLS, also where are they available to be bought?
> >
> > Jordan
> >
> > P.S. - I didn't see a 1003 version of the -D bios at ftp.asuscom.de but
> > I did see a 1004 version.  I also did not see a DLS bios listed at all,
> > this board is hinted at and has basic specs listed at several sites on
> > the internet, does it exist, can it be bought?  Thanks for any
> > information that you can give me about the CUV266-DLS.  BTW, the
> > unexpected APIC thing is no big deal, it is saying that one of the
> > registers of the APIC stuff is set to something that was unexpected, it
> > happens on almost all current SMP boards I have worked with.
> >


