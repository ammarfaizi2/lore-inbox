Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268130AbTGLQ4q (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 12:56:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268110AbTGLQ4c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 12:56:32 -0400
Received: from main.gmane.org ([80.91.224.249]:51927 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S268115AbTGLQ4S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 12:56:18 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Jan Rychter <jan@rychter.com>
Subject: Re: networking bugs and bugme.osdl.org
Date: Sat, 12 Jul 2003 10:07:42 -0700
Message-ID: <m2vfu765cx.fsf@tnuctip.rychter.com>
References: <1056755336.5459.16.camel@dhcp22.swansea.linux.org.uk> <20030627.172123.78713883.davem@redhat.com>
 <1056827972.6295.28.camel@dhcp22.swansea.linux.org.uk>
 <20030628.150328.74739742.davem@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
X-Complaints-To: usenet@main.gmane.org
X-Spammers-Please: blackholeme@rychter.com
User-Agent: Gnus/5.1003 (Gnus v5.10.3) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:Q5NfW1XO9gryg4flfNXqetJHZ5Y=
Cc: linux-net@vger.kernel.org, netdev@oss.sgi.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Transfer-Encoding: quoted-printable

>>>>> "David" =3D=3D David S Miller <davem@redhat.com> writes:
 David> From: Alan Cox <alan@lxorguk.ukuu.org.uk> Date: 28 Jun 2003
 David> 20:19:32 +0100

 David> On Sad, 2003-06-28 at 01:21, David S. Miller wrote:
 >> I respond to private reports with "please send this to the lists,
 >> what if I were on vacation for the next month?"  I never actually
 >> process or analyze such reports.
=20=20=20
 David> Which means you miss stuff.

 David> Not my problem Alan.  If the user gives a crap about their
 David> report mattering, they'll do what I ask them to do.  If users
 David> send their report to the wrong place, it will get lost, just
 David> like if their cat their report into /dev/null.  I have no reason
 David> to feel bad about the information getting lost.

 David> If it's too much for them to do as I ask, it's too much for me
 David> to consider their report.
[...]

I think this is one of the largest problems of the current Linux
development model.

Many people seem to divide people into 'users' (who aren't particularly
useful) and 'developers', who actually do something. People (like me),
who can devote a _little_ time to narrowing down and reporting bugs fall
into the 'user-whiner' class. And get ignored.

What results is that you only get bug reports from active
developers. Which means that rare bugs don't get fixed.

 David> It is not a dream, it works perfectly fine and has done so for
 David> 5+ years of Linux maintainence.

It hasn't. The result is a system that works for you (and other active
developers), but not for everyone. As an example -- try running Linux on
a modern laptop, connecting some USB devices, using ACPI, or
bluetooth. Observe the resulting problems and crashes. You'll hit loads
of obscure bugs that have been reported, but never got looked at in
detail. I certainly have hit them and reported most, and most got
dropped in various places.

Does this mean these are unimportant bugs? No. This does indeed mean
(following your thinking) that these aren't important bugs for me. I
have worked around them in various ways, some involving actually buying
new hardware, or not using certain features at all. And the cycle will
go on -- others will hit the bugs, report them once, see them dropped,
move on.

 David> Let's see, what makes more sense from my perspective.  Should I
 David> reward and put forth effort for the people who fart a bug report
 David> onto the lists and expect everyone to stop what they're doing
 David> and fix the bug, or should I reward and put forth effort for the
 David> guy who spent the time to put together a stellar bug report and
 David> also doesn't mind retransmitting it from time to time whilst
 David> everyone is busy?

Interesting you should think you're 'rewarding' people. I thought your
goal was to have fun working on cool software and making it
better. I also thought I had the same goal as a bug-reporter.

When I write software, I care about every bug report and consider people
doing the reporting a very valuable resource.

=2D-J.

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/EEBjLth4/7/QhDoRAra7AKDtnJwjGSrjhkFYu4jPKWcdBD/uagCcCl1c
J0eXeqyfh5xI4A8QMxI5PkE=
=MxwA
-----END PGP SIGNATURE-----
--=-=-=--

