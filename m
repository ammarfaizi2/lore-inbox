Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262680AbSI1KTB>; Sat, 28 Sep 2002 06:19:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262654AbSI1KTB>; Sat, 28 Sep 2002 06:19:01 -0400
Received: from sproxy.gmx.de ([213.165.64.20]:53347 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S262680AbSI1KTA>;
	Sat, 28 Sep 2002 06:19:00 -0400
Date: Sat, 28 Sep 2002 12:23:49 +0200
From: Marc Giger <gigerstyle@gmx.ch>
To: Felix Seeger <felix.seeger@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: System very unstable
Message-Id: <20020928122349.60be48b4.gigerstyle@gmx.ch>
In-Reply-To: <200209281134.27362.felix.seeger@gmx.de>
References: <200209281115.19968.felix.seeger@gmx.de>
	<1033205547.17777.13.camel@irongate.swansea.linux.org.uk>
	<200209281134.27362.felix.seeger@gmx.de>
X-Mailer: Sylpheed version 0.8.3claws (GTK+ 1.2.10; )
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 28 Sep 2002 11:34:27 +0200
Felix Seeger <felix.seeger@gmx.de> wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Am Samstag, 28. September 2002 11:32 schrieb Alan Cox:
> > > EIP:    0010:[get_new_inode+94/368]    Tainted: P
> > > EFLAGS: 00010206
> > > eax: f1ec9808   ebx: 00000000   ecx: c1376130 edx: c3761dc8
> >
> > You appear to have some non typical modules loaded. If they are binary
> > ones from people like Nvidia please see if the box is stable without
> > them ever being loaded.
> Yes I am using the nvidia module. But I don't think that is the problem, 
> because I never had such problems with it.
> The only thing I can imagine is that:
> I installed the new module and I looked very unstable. So I installed the old 
> one again.
> 
Yes and that's the point. You're using the 1.0.3123 Version of nvidia's module, right? I tried this also, but after 1 hour I removed it again, because they are very instable. I don't know what nvidia thinks. Probably nothing. Their drivers are unworthy. It won't take a long time, until I will buy a graphic-card from another manufacturer. Perhaps Matrox Parhelia:-)

> > If its only just begun happening and you didnt change these modules or
> > the kernel then it may well be worth checking CPU temperature in the
> > BIOS, the fans and/or running memtest86 to see if it is hardware.
> >
> > If you've changed kernel obviously see if the old one works reliably
> > first
> 
> Thanks, I will do that.
> 
> have fun
> Felix
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.0.7 (GNU/Linux)
> 
> iD8DBQE9lXejS0DOrvdnsewRAka2AJ9EGwZ/h3WczFx59gU0hJSlkHeuGQCfdgzY
> FN0ppyzAY4Hm00Mz0Zg7DTs=
> =jlDs
> -----END PGP SIGNATURE-----
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
