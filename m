Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268166AbTAKWRm>; Sat, 11 Jan 2003 17:17:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268165AbTAKWRm>; Sat, 11 Jan 2003 17:17:42 -0500
Received: from etpmod.phys.tue.nl ([131.155.111.35]:29259 "EHLO
	etpmod.phys.tue.nl") by vger.kernel.org with ESMTP
	id <S268166AbTAKWRj>; Sat, 11 Jan 2003 17:17:39 -0500
Date: Sat, 11 Jan 2003 23:26:19 +0100
From: Kurt Garloff <kurt@garloff.de>
To: Rob Wilkens <robw@optonline.net>
Cc: Linux kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Nvidia and its choice to read the GPL "differently"
Message-ID: <20030111222619.GG9153@nbkurt.casa-etp.nl>
Mail-Followup-To: Kurt Garloff <kurt@garloff.de>,
	Rob Wilkens <robw@optonline.net>,
	Linux kernel list <linux-kernel@vger.kernel.org>
References: <7BFCE5F1EF28D64198522688F5449D5A03C0F4@xchangeserver2.storigen.com> <1042250324.1278.18.camel@RobsPC.RobertWilkens.com> <20030111020738.GC9373@work.bitmover.com> <1042251202.1259.28.camel@RobsPC.RobertWilkens.com> <20030111021741.GF9373@work.bitmover.com> <1042252717.1259.51.camel@RobsPC.RobertWilkens.com> <20030111214437.GD9153@nbkurt.casa-etp.nl> <1042322012.1034.6.camel@RobsPC.RobertWilkens.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Y+xroYBkGM9OatJL"
Content-Disposition: inline
In-Reply-To: <1042322012.1034.6.camel@RobsPC.RobertWilkens.com>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.4.19-UL1 i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TU/e(NL), SuSE(DE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Y+xroYBkGM9OatJL
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Rob,

You seem to serious ...

On Sat, Jan 11, 2003 at 04:53:33PM -0500, Rob Wilkens wrote:
> I'd say terribly presumptuous, but I don't think it is presumptuous to
> say that if there are many patches (bug fixes, mostly) coming in that
> the code that was originally there was of questionable quality.

It is presumptuous. Very much so.

1. A patch does not necessarily indicate something is wrong with the
   original code. It may only show that people have ideas on how to
   do things better, more efficiently, more nicely or to support
   new features or hardware.
2. If a patch fixes a bug, you should be aware that the complexity
   of an operating system is slightly higher than you think.
   We're talking about a general purpose operating system that works
   in real life and solves problems there. Not a toy system or a
   specialized one.
3. The amount of supported subsystems and hardware of the Linux kernel
   is enormous. The hardware you deal with very often already is complex
   and/or buggy. And needs things you never even thought about when
   doing userspace programs before. Like protection from concurrent=20
   accesses to hardware.
4. In kernel land, you have less tools available than a normal programmer
   has. Things you assume just to be there and to work in userland programs
   are unavailable and have to be done by yourself. Like I/O. Memory
   allocation and management.=20
5. The impact of a bug in kernel is much higher than in a normal program.

It is na=EFve to believe that the fact that many bugs are found indicates=
=20
poor quality of a code.=20

Just compare the stability of Linux to other operating systems. Take=20
the toy OSes that most desktop users prefer or the somewhat better
alternatives offered for professional customers by the same company
on the one side. Take commercial Un*ces on the other.
And then consider the amount of things that Linux does have support for=20
in kernel. For example the IPv4 stack or netfilter. And take into account
the amount of hardware Linux supports. Think about performance as well.
Think about conforming to specifications, like POSIX.

It's amazing. And most people would not have believed that this can work,
certainly not outside of a very tightly controlled process in a company.
It does.=20
And this is the merit of many enthusiasts and last not least Linus.

Questioning the skills of the people involved is ridicolous at best.
You also think that those people doing research on operating systems
in CS departments are just doing simplistic stuff?

Go and start to work on a free software project of comparable size.
If you think you can do it, create Robix. If your enthusiast enough,
and technically good enough, you will find people who find it exciting
and will help you.

Regards,
--=20
Kurt Garloff                   <kurt@garloff.de>         [Eindhoven, NL]
Physics: Plasma simulations    <K.Garloff@TUE.NL>     [TU Eindhoven, NL]
Linux: SCSI, Security          <garloff@suse.de>    [SuSE Nuernberg, DE]
 (See mail header or public key servers for PGP2 and GPG public keys.)

--Y+xroYBkGM9OatJL
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+IJoKxmLh6hyYd04RAkaJAJ9ToJb7SjABzCK0xjzqdHfmFabLRwCdEh5W
Pxdy9xtRf4OlQLGxUsvKSHE=
=Grq1
-----END PGP SIGNATURE-----

--Y+xroYBkGM9OatJL--
