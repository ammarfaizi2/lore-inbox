Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262924AbUCWXqN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 18:46:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262927AbUCWXqM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 18:46:12 -0500
Received: from MailBox.iNES.RO ([80.86.96.21]:21520 "EHLO MailBox.iNES.RO")
	by vger.kernel.org with ESMTP id S262924AbUCWXqG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 18:46:06 -0500
Subject: Re: [Swsusp-devel] Re: swsusp problems [was Re: Your opinion on
	the merge?]
From: Dumitru Ciobarcianu <Dumitru.Ciobarcianu@iNES.RO>
To: ncunningham@users.sourceforge.net
Cc: Pavel Machek <pavel@suse.cz>, Michael Frank <mhf@linuxmail.org>,
       Jonathan Sambrook <swsusp@hmmn.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Swsusp mailing list <swsusp-devel@lists.sourceforge.net>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <1080081396.22641.9.camel@calvin.wpcb.org.au>
References: <1079661410.15557.38.camel@calvin.wpcb.org.au>
	 <20040318200513.287ebcf0.akpm@osdl.org>
	 <1079664318.15559.41.camel@calvin.wpcb.org.au>
	 <20040321220050.GA14433@elf.ucw.cz>
	 <1079988938.2779.18.camel@calvin.wpcb.org.au>
	 <20040322231737.GA9125@elf.ucw.cz> <20040323095318.GB20026@hmmn.org>
	 <20040323214734.GD364@elf.ucw.cz>
	 <1080076132.12965.18.camel@calvin.wpcb.org.au>
	 <opr5b7tyt24evsfm@smtp.pacific.net.th>  <20040323231715.GH364@elf.ucw.cz>
	 <1080081396.22641.9.camel@calvin.wpcb.org.au>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-uC13GM2fvdqn2xEugSIY"
Organization: iNES Group
Message-Id: <1080085523.13833.9.camel@LNX.iNES.RO>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.5.5 
Date: Wed, 24 Mar 2004 01:45:23 +0200
X-RAVMilter-Version: 8.4.1(snapshot 20020919) (MailBox.iNES.RO)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-uC13GM2fvdqn2xEugSIY
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2004-03-24 at 10:36 +1200, Nigel Cunningham wrote:

> I could always make the ui a plugin too - along the lines of what
> Michael is suggesting. That would be really simple: separate out the
> bootsplash code and the text mode code into new files, perhaps in a ui
> directory and adjust the Makefile & config.in accordingly.


Speaking from an swsusp user (not developer) this is the best thing
imho. Some people just love eye candy :)



--=20
Dumitru "Eyecandy Lover" C.

--=-uC13GM2fvdqn2xEugSIY
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAYMwTQisRnSkd59cRAlakAJ4jw7oH4tit0YtY9IG670KkzzHkvACgi3GO
o3Ok1L6pkOueeNpK5t/wuok=
=KApR
-----END PGP SIGNATURE-----

--=-uC13GM2fvdqn2xEugSIY--

