Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262654AbSI1KZ6>; Sat, 28 Sep 2002 06:25:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262691AbSI1KZ6>; Sat, 28 Sep 2002 06:25:58 -0400
Received: from mail.gmx.net ([213.165.64.20]:48766 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S262654AbSI1KZ5>;
	Sat, 28 Sep 2002 06:25:57 -0400
From: Felix Seeger <felix.seeger@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Re: System very unstable
Date: Sat, 28 Sep 2002 12:31:10 +0200
User-Agent: KMail/1.4.7
References: <200209281115.19968.felix.seeger@gmx.de> <200209281134.27362.felix.seeger@gmx.de> <20020928122349.60be48b4.gigerstyle@gmx.ch>
In-Reply-To: <20020928122349.60be48b4.gigerstyle@gmx.ch>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200209281231.11057.felix.seeger@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Am Samstag, 28. September 2002 12:23 schrieb Marc Giger:
> On Sat, 28 Sep 2002 11:34:27 +0200
>
> Felix Seeger <felix.seeger@gmx.de> wrote:
> > -----BEGIN PGP SIGNED MESSAGE-----
> > Hash: SHA1
> >
> > Am Samstag, 28. September 2002 11:32 schrieb Alan Cox:
> > > > EIP:    0010:[get_new_inode+94/368]    Tainted: P
> > > > EFLAGS: 00010206
> > > > eax: f1ec9808   ebx: 00000000   ecx: c1376130 edx: c3761dc8
> > >
> > > You appear to have some non typical modules loaded. If they are binary
> > > ones from people like Nvidia please see if the box is stable without
> > > them ever being loaded.
> >
> > Yes I am using the nvidia module. But I don't think that is the problem,
> > because I never had such problems with it.
> > The only thing I can imagine is that:
> > I installed the new module and I looked very unstable. So I installed the
> > old one again.
>
> Yes and that's the point. You're using the 1.0.3123 Version of nvidia's
> module, right? 
> I tried this also, but after 1 hour I removed it again,
> because they are very instable. I don't know what nvidia thinks. Probably
> nothing. Their drivers are unworthy. It won't take a long time, until I
> will buy a graphic-card from another manufacturer. Perhaps Matrox
> Parhelia:-)

No, I installed that module, very unstable and installed the old one again 
like you ;)

> > > If its only just begun happening and you didnt change these modules or
> > > the kernel then it may well be worth checking CPU temperature in the
> > > BIOS, the fans and/or running memtest86 to see if it is hardware.
> > >
> > > If you've changed kernel obviously see if the old one works reliably
> > > first

have fun
Felix
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9lYTuS0DOrvdnsewRAuPCAJwIKCT4gQUvRxkjKrPdngM8BaiePQCeM3Ms
vNWRu3N6aGdN+Mkm5z0CXLs=
=fD9/
-----END PGP SIGNATURE-----

