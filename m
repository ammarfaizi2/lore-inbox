Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262068AbSIYTMo>; Wed, 25 Sep 2002 15:12:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262069AbSIYTMo>; Wed, 25 Sep 2002 15:12:44 -0400
Received: from line106-15.adsl.actcom.co.il ([192.117.106.15]:53395 "EHLO
	www.veltzer.org") by vger.kernel.org with ESMTP id <S262068AbSIYTMn>;
	Wed, 25 Sep 2002 15:12:43 -0400
Message-Id: <200209251929.g8PJTPN05751@www.veltzer.org>
Content-Type: text/plain; charset=US-ASCII
From: Mark Veltzer <mark@veltzer.org>
Organization: Meta Ltd.
To: Rik van Riel <riel@conectiva.com.br>, Mark Mielke <mark@mark.mielke.cc>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Peter Svensson <petersv@psv.nu>
Subject: Re: Offtopic: (was Re: [ANNOUNCE] Native POSIX Thread Library 0.1)
Date: Wed, 25 Sep 2002 22:29:22 +0300
X-Mailer: KMail [version 1.3.2]
References: <Pine.LNX.4.44L.0209251602170.22735-100000@imladris.surriel.com>
In-Reply-To: <Pine.LNX.4.44L.0209251602170.22735-100000@imladris.surriel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Wednesday 25 September 2002 22:04, you wrote:
> On Wed, 25 Sep 2002, Mark Mielke wrote:
> > I missed this one. Does this mean that fork() bombs will have limited
> > effect on root? :-)
>
> Indeed. A user can easily run 100 while(1) {} loops, but to the
> other users in the system it'll feel just like 1 loop...

Rik!

This is terrific!!! How come something like this was not merged in earlier 
?!? This seems like an absolute neccesity!!! I'm willing to test it if that 
is what is needed to get it merged. What does Linus and others feel about 
this and most importantly when will see it in ? (Hopefully in this 
development cycle).

	Regards,
	Mark
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9kg6SxlxDIcceXTgRApApAKClB60zgDs0OB1ltb2ha0Lo8cescgCfTVE7
ZiNKbiTAN78LecVGt6/JzPU=
=/z0y
-----END PGP SIGNATURE-----
