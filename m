Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291707AbSBNPTU>; Thu, 14 Feb 2002 10:19:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291712AbSBNPTL>; Thu, 14 Feb 2002 10:19:11 -0500
Received: from mail.gmx.net ([213.165.64.20]:36492 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S291707AbSBNPS6>;
	Thu, 14 Feb 2002 10:18:58 -0500
Date: Thu, 14 Feb 2002 16:22:32 +0100
From: Sebastian =?ISO-8859-1?Q?Dr=F6ge?= <sebastian.droege@gmx.de>
To: Oleg Drokin <green@namesys.com>
Cc: reiserfs-list-subscribe@namesys.com, linux-kernel@vger.kernel.org
Subject: Re: Reiserfs Corruption with 2.5.5-pre1
Message-Id: <20020214162232.5e59193b.sebastian.droege@gmx.de>
In-Reply-To: <20020214180501.A1755@namesys.com>
In-Reply-To: <20020214155716.3b810a91.sebastian.droege@gmx.de>
	<20020214180501.A1755@namesys.com>
X-Mailer: Sylpheed version 0.7.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 boundary="=.yPuXoNw.O/BT.I"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.yPuXoNw.O/BT.I
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 14 Feb 2002 18:05:01 +0300
Oleg Drokin <green@namesys.com> wrote:

> Hello!
> 
> On Thu, Feb 14, 2002 at 03:57:16PM +0100, Sebastian Dr?ge wrote:
> 
> > after starting GNOME with 2.5.5-pre1 with reiserfs on the root partition I get several funny-named files in ~/.gnome/accels and I can't start some programms anymore... When I reboot into 2.4.17 again everything works right and this files are gone again
> 
> Hm. I was not able to run 2.5.5-pre1 with reiserfs support without patch
> attached at all.
> 
> > This only happens with any kernel since 2.5.4-pre* or so and it happens everytime I try to start GNOME under such kernel.
> 
> Have you tried to run reiserfsck on your partition after 2.5.4-pre1
> Run reiserfsck and never use 2.5.4-pre1 or earlier 2.5 kernels.
Thanks I'll try that
*bootingfromcdandrunningreiserfsck* ;)
Bye
--=.yPuXoNw.O/BT.I
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)

iD8DBQE8a9Y6e9FFpVVDScsRAlowAJ9qB/bE22n8FAFu22H//awqDJWN/wCffe7j
Ubp/+iMLnvBA95VLgZSEqDE=
=Jxfx
-----END PGP SIGNATURE-----

--=.yPuXoNw.O/BT.I--

