Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262763AbSI1JdW>; Sat, 28 Sep 2002 05:33:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262760AbSI1Jcs>; Sat, 28 Sep 2002 05:32:48 -0400
Received: from sproxy.gmx.net ([213.165.64.20]:7862 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S262763AbSI1J3M>;
	Sat, 28 Sep 2002 05:29:12 -0400
From: Felix Seeger <felix.seeger@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Re: System very unstable
Date: Sat, 28 Sep 2002 11:34:27 +0200
User-Agent: KMail/1.4.7
References: <200209281115.19968.felix.seeger@gmx.de> <1033205547.17777.13.camel@irongate.swansea.linux.org.uk>
In-Reply-To: <1033205547.17777.13.camel@irongate.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200209281134.27362.felix.seeger@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Am Samstag, 28. September 2002 11:32 schrieb Alan Cox:
> > EIP:    0010:[get_new_inode+94/368]    Tainted: P
> > EFLAGS: 00010206
> > eax: f1ec9808   ebx: 00000000   ecx: c1376130 edx: c3761dc8
>
> You appear to have some non typical modules loaded. If they are binary
> ones from people like Nvidia please see if the box is stable without
> them ever being loaded.
Yes I am using the nvidia module. But I don't think that is the problem, 
because I never had such problems with it.
The only thing I can imagine is that:
I installed the new module and I looked very unstable. So I installed the old 
one again.

> If its only just begun happening and you didnt change these modules or
> the kernel then it may well be worth checking CPU temperature in the
> BIOS, the fans and/or running memtest86 to see if it is hardware.
>
> If you've changed kernel obviously see if the old one works reliably
> first

Thanks, I will do that.

have fun
Felix
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9lXejS0DOrvdnsewRAka2AJ9EGwZ/h3WczFx59gU0hJSlkHeuGQCfdgzY
FN0ppyzAY4Hm00Mz0Zg7DTs=
=jlDs
-----END PGP SIGNATURE-----

