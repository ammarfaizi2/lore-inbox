Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264942AbRGGEfJ>; Sat, 7 Jul 2001 00:35:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265980AbRGGEe7>; Sat, 7 Jul 2001 00:34:59 -0400
Received: from 35.roland.net ([65.112.177.35]:35340 "EHLO earth.roland.net")
	by vger.kernel.org with ESMTP id <S264942AbRGGEev>;
	Sat, 7 Jul 2001 00:34:51 -0400
Message-ID: <00b801c1069e$3a68a320$bb1cfa18@JimWS>
From: "Jim Roland" <jroland@roland.net>
To: "Stephen M. Williams" <rootusr@midsouth.rr.com>,
        <joe.mathewson@btinternet.com>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <200107041849.f64InoE12398@ambassador.mathewson.int> <994477990.4918.2.camel@bofumgw.bofum.net>
Subject: Re: [OT] Suitable Athlon Motherboard for Linux
Date: Fri, 6 Jul 2001 23:35:19 -0500
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

Unfortunately, some distros will have some configurations, patches, and
customizations that may cause problems with some systems.  I am using an
EPoX 8KTA3+ (with IDE ATA100 RAID controller) and have absolutely no
problems with RedHat 6.1, or my current RedHat 7.1, and I am using the RAID
controller in a non-RAID configuration.  Using Mandrake for critical
applications such as servers and firewalls, I have always had "strange"
unexplained lock-ups, etc (that was on Mandrake 7.0).  What will really
matter is what hardware you're plugging into the motherboard and it's
interaction with those cards.

My system (which runs without any problems whatsoever):
EPoX 8KTA3+ Mainboard
Athlon K7 1.2GHz
512MB RAM
1 CDROM on IDE0 (standard 52x)
1 CDRW on IDE1 (Plextor Plexwriter 16/10/40A)
1 30 GB Seagate HD on IDE2 (Highpoint RAID Controller part of mainboard)
1 6GB Western Digital on IDE3 (Highpoint RAID Controller part of mainboard)
GeForce2 MX (32MB RAM)
Netgear FA311 NIC



----- Original Message -----
From: "Stephen M. Williams" <rootusr@midsouth.rr.com>
To: <joe.mathewson@btinternet.com>
Cc: <linux-kernel@vger.kernel.org>
Sent: Friday, July 06, 2001 10:52 PM
Subject: Re: [OT] Suitable Athlon Motherboard for Linux


> Seems to run fine here.  I'm using a Tyan S2380 (600MHz pre-Thunderbird)
> with the VIA KX-133 chipset, running Kernel 2.4.5
>
> On 04 Jul 2001 19:49:50 +0100, Joseph Mathewson wrote:
> > Having heard the various horror stories about the VIA PCI data
corruption
> > bugs, and watching one Via based machine destroy itself with a Mandrake
8.0
> >  2.4.3, I was just wondering if anyone had a suggestion for an Athlon
> > motherboard that works reliably under Linux (I don't think all the
issues
> > have been cleared up in the kernel yet?).  There must be quite a few
Linux
> > Athlon users out there - what boards are you using and with what
success?
> >
> > I can't see much alternative to Via chipsets in the Ahtlon market, other
> > than all-in-one-graphics-sound-network jobbies that, from previous
> > experience (namely the i810), are also best avoided.
> >
> > Joe.
>
> Stephen Williams
> mailto:rootusr@midsouth.rr.com
>
> * I've tried killing time, but it keeps making a comeback.
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

