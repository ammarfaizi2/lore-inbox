Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265089AbUGLMza@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265089AbUGLMza (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 08:55:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266687AbUGLMza
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 08:55:30 -0400
Received: from ns0.eris.qinetiq.com ([128.98.1.1]:20855 "HELO
	mail.eris.qinetiq.com") by vger.kernel.org with SMTP
	id S265089AbUGLMz1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 08:55:27 -0400
From: Mark Watts <m.watts@eris.qinetiq.com>
Organization: QinetiQ
To: linux-kernel@vger.kernel.org
Subject: Re: 1000 days uptime.
Date: Mon, 12 Jul 2004 13:50:51 +0100
User-Agent: KMail/1.6.1
Cc: Wakko Warner <wakko@animx.eu.org>, Nick Warne <nick@linicks.net>,
       hants@mailman.lug.org.uk
References: <Pine.LNX.4.44.0407102122060.21103-100000@linicks.net> <20040710224703.GA19378@animx.eu.org>
In-Reply-To: <20040710224703.GA19378@animx.eu.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <200407121350.52127.m.watts@eris.qinetiq.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


> > This is a 486 box serving web pages from a home base (via NFS to
> > gateway). No UPS, no special treatment expect dust and usual day-to-day
> > abuse stuck under two other boxes in a 'stack' of sorts I done a long
> > time ago...
> >
> > [nick@486Linux nick]$ uptime
> >   9:29pm  up 6 days,  1:40,  1 user,  load average: 0.15, 0.05, 0.10
> >
> > [nick@486Linux nick]$ last -xf /var/run/utmp runlevel
> > runlevel (to lvl 3)                    Sun Oct 14 16:07 - 21:29
> > (1000+05:22)
> >
> > [nick@486Linux nick]$ uname -a
> > Linux 486Linux 2.2.13-7mdk #1 Wed Sep 15 18:02:18 CEST 1999 i486 unknown
>
> Show off...
>
> [wakko@rod:/home/wakko] uptime ; last -xf /var/run/utmp runlevel
>   6:56pm  up 204 days, 14:40h,  3 users,  load average: 0.00, 0.00, 0.00
>   runlevel (to lvl 5)                    Thu Nov 18 22:36 - 18:56
> (1695+19:20)
>
> utmp begins Thu Nov 18 22:36:07 1999
> [wakko@rod:/home/wakko] uname -a
> Linux rod 2.2.13 #1 Thu Nov 18 20:59:01 EST 1999 i586 unknown
> [wakko@rod:/home/wakko]
>
>
> However, I do have mine on a UPS (literally =)
>
> Kinda funny that it's basically the same kernel (Just yours is from
> mandrake and mine is self compiled)

$ uname -a
Linux server1 2.4.18-6mdk #1 Fri Mar 15 02:59:08 CET 2002 i686 unknown
$  last -xf /var/run/utmp runlevel
runlevel (to lvl 3)                    Thu May 30 15:14 - 14:02 (773+22:47)

utmp begins Thu May 30 15:14:42 2002

Do I get the prize for a 2.4 kernel ? =)

- -- 
Mark Watts
Senior Systems Engineer
QinetiQ Trusted Information Management
Trusted Solutions and Services group
GPG Public Key ID: 455420ED

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA8oksBn4EFUVUIO0RAr5QAJ9PhoGM59jQ21P5/4VttJEpkAxiDgCgwhuX
P4A/7bUugL3LSzUJlhbq0lQ=
=m9W3
-----END PGP SIGNATURE-----
