Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282397AbRK0SjI>; Tue, 27 Nov 2001 13:39:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281322AbRK0SjD>; Tue, 27 Nov 2001 13:39:03 -0500
Received: from mail.gmx.de ([213.165.64.20]:51633 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S282470AbRK0Siy> convert rfc822-to-8bit;
	Tue, 27 Nov 2001 13:38:54 -0500
Content-Type: text/plain; charset=US-ASCII
From: Sebastian =?iso-8859-1?q?Dr=F6ge?= <sebastian.droege@gmx.de>
Reply-To: sebastian.droege@gmx.de
To: linux-kernel@vger.kernel.org
Subject: Re: "spurious 8259A interrupt: IRQ7"
Date: Tue, 27 Nov 2001 19:40:27 +0100
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <XFMail.20011127152007.ast@domdv.de> <01112716302905.00872@manta>
In-Reply-To: <01112716302905.00872@manta>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011127183856Z282470-17408+21175@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,
I've had this very message, too.
System is a PII 350, MSI-6151 motherboard with Intel BX chipset
But it's a time ago I had it ;)
When I remember right it was the one kernel I've enabled APIC/IO-APIC but I'm
not sure. Right now I have no APIC/IO-APIC enabled.
I'll test it later the day
Bye


Am Dienstag, 27. November 2001 19:30 schrieb vda:
 On Tuesday 27 November 2001 12:20, Andreas Steinmetz wrote:
> > As far as I remember this was talked about earlier. Different mobos,
> > chipsets, processor brands, but always IRQ 7. /me wonders. At least it
> > doesn't do any harm (got this message on nearly all or all of my
> > systems).
> >
> > On 27-Nov-2001 Alan Cox wrote:
> > >> I get this with 2.4.16 vanilla, though. IRQ 7 appears to be unassigned
> > >> according to /proc/pci.
> > >>
> > >> Machine is a 1ghz Athlon on a VIA VT82C686 mobo and a DEC 21140 NIC.
> > >>
> > >> Any pointers appreciated.
> > >
> > > IRQ7 is asserted when the PIC sees an interrupt but nobody appears to
> > > be generating it when it looks.
>
> I see it too on my home system (Duron 650 + VIA chipset)

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8A94fvIHrJes3kVIRAr3SAKCdcisZj7yfj7mENPSEc2h/Bq+AlQCfVC5i
/wx+DcuyM4OH29GinxEEnYI=
=LDkl
-----END PGP SIGNATURE-----
