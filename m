Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279865AbRKIMne>; Fri, 9 Nov 2001 07:43:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279878AbRKIMnZ>; Fri, 9 Nov 2001 07:43:25 -0500
Received: from [194.51.220.145] ([194.51.220.145]:43625 "EHLO emeraude")
	by vger.kernel.org with ESMTP id <S279873AbRKIMnM>;
	Fri, 9 Nov 2001 07:43:12 -0500
Date: Fri, 9 Nov 2001 13:34:53 +0100
From: Stephane Jourdois <stephane@tuxfinder.org>
To: Massimo Dal Zotto <dz@cs.unitn.it>
Cc: LKLM <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] SMM BIOS on Dell i8100
Message-ID: <20011109133453.A8130@emeraude.kwisatz.net>
Reply-To: stephane@tuxfinder.org
In-Reply-To: <200111081814.fA8IE4qi003266@dizzy.dz.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DocE+STaALJfprDB"
Content-Disposition: inline
In-Reply-To: <200111081814.fA8IE4qi003266@dizzy.dz.net>
User-Agent: Mutt/1.3.23i
X-Operating-System: Linux 2.4.15-pre1
X-Send-From: emeraude
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--DocE+STaALJfprDB
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 08, 2001 at 07:14:03PM +0100, Massimo Dal Zotto wrote:
> I have released version 1.4 of my package with a new kernel module and
> some enhancements to the i8kmon utility.

hello,

[no patch today :-)]

here is what top gives me :
  PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME COMMAND
 8102 kwisatz   15   0  2612 2612  1804 S     1.3  0.5   0:01 tclsh
 1663 kwisatz   10   0  3172 2436  2028 S     0.1  0.4   0:25 gkrellm

It seems that gkrellm (which monitors more than 20 things on my laptop)
takes only 0.1% of cpu, whereas i8kmon takes 1.3%...
I have absolutely no idea how to improve that, but I think that should
be the first thing on the TODO :-)

++

--=20
 ///  Stephane Jourdois        	/"\  ASCII RIBBON CAMPAIGN \\\
(((    Ing=E9nieur d=E9veloppement 	\ /    AGAINST HTML MAIL    )))
 \\\   6, av. de la Belle Image	 X                         ///
  \\\  94440 Marolles en Brie  	/ \    +33 6 8643 3085    ///

--DocE+STaALJfprDB
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjvrzW0ACgkQk2dpMN4A2NMNWgCeIbbDQl5QsK4dY8wkw/qLhW+Q
OuoAnAm6CnigWmpzYW8i8FdCxkZb6K2F
=a6BO
-----END PGP SIGNATURE-----

--DocE+STaALJfprDB--
