Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271417AbTGQKxm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 06:53:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271419AbTGQKxl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 06:53:41 -0400
Received: from ns0.eris.qinetiq.com ([128.98.1.1]:56199 "HELO
	mail.eris.qinetiq.com") by vger.kernel.org with SMTP
	id S271417AbTGQKxf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 06:53:35 -0400
Content-Type: text/plain; charset=US-ASCII
From: Mark Watts <m.watts@eris.qinetiq.com>
Organization: QinetiQ
To: Thierry Vignaud <tvignaud@mandrakesoft.com>
Subject: Re: devfsd/2.6.0-test1
Date: Thu, 17 Jul 2003 12:07:24 +0100
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org
References: <200307171017.56778.m.watts@eris.qinetiq.com> <m265m1fp3u.fsf@vador.mandrakesoft.com>
In-Reply-To: <m265m1fp3u.fsf@vador.mandrakesoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200307171207.25284.m.watts@eris.qinetiq.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


> Mark Watts <m.watts@eris.qinetiq.com> writes:
> > I'm running devfs on a 2.6.0-test1 box (Mandrake 9.1 with the new
> > kernel)
> >
> > Every time I boot, it complains that I don't have an
> > /etc/modprobe.devfs.  If I symlink modules.devfs, I get a wad of
> > errors about 'probeall'.  What should a modprobe.devfs look like for
> > a 2.5/6 kernel?
>
> tv@vador ~ $ urpmf /etc/modprobe.devfs
> module-init-tools:/etc/modprobe.devfs
>

Interesting, an urpmf for that on my 9.1 box reveals nothing...

Thanks for the pointer...

Mark.

- -- 
Mark Watts
Senior Systems Engineer
QinetiQ TIM
St Andrews Road, Malvern
GPG Public Key ID: 455420ED

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/FoNtBn4EFUVUIO0RAtsrAKDv8zNE7UwPttJ50cw5IFT4riRzFACfRQYy
dhUB9kqE4EX3ybdcieLiEbU=
=xA0b
-----END PGP SIGNATURE-----

