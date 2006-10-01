Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751277AbWJAQtA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751277AbWJAQtA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 12:49:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751271AbWJAQtA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 12:49:00 -0400
Received: from pool-72-66-199-147.ronkva.east.verizon.net ([72.66.199.147]:32453
	"EHLO turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1751268AbWJAQtA (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 12:49:00 -0400
Message-Id: <200610011648.k91Gmtc4032526@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: tridge@samba.org, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: GPLv3 Position Statement
In-Reply-To: Your message of "Sun, 01 Oct 2006 10:45:50 CDT."
             <1159717550.3542.3.camel@mulgrave.il.steeleye.com>
From: Valdis.Kletnieks@vt.edu
References: <1159498900.3880.31.camel@mulgrave.il.steeleye.com> <17692.46192.432673.743783@samba.org> <1159515086.3880.79.camel@mulgrave.il.steeleye.com> <17692.57123.749163.204216@samba.org> <1159559443.9543.23.camel@mulgrave.il.steeleye.com> <17694.5933.159694.454938@samba.org> <1159628796.9543.69.camel@mulgrave.il.steeleye.com> <17695.24581.587794.831888@samba.org>
            <1159717550.3542.3.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1159721335_8054P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sun, 01 Oct 2006 12:48:55 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1159721335_8054P
Content-Type: text/plain; charset=us-ascii

On Sun, 01 Oct 2006 10:45:50 CDT, James Bottomley said:
> Erm ... I think you'll find there's already case law precedent on that:
> the SCO case.  The question there was could SCO sue IBM for copyright
> infringement after having distributed the kernel from their website.
> The answer, from the judge in the case, was yes.

(IANAL, just an interested amature bystander - if my explanation actually
matters to anybody, they should hire competent legal representation instead)

Note that the precedent set there was "Yes, you can *file suit* about it",
handed down by a judge that is being *very* careful to not leave *any*
possible reason for SCO to have grounds for an appeal (and "judge improperly
denied our cause of action" would likely qualify for an appeal).

(For those readers outside the US - due to quirks in the US legal system,
it *is* permissible to bankrupt yourself by filing pointless lawsuits that
have no chance of winning.  The truly dangerous part is that the people you
sue often countersue, and include "and attourney's fees" in the list of
damages they claim.  So if you sue somebody and it costs them $150K to
defend themselves against a pointless lawsuit, you can end up owing them
$150K....)

IBM recently filed a motion for summary judgement on one of their
counterclaims, which basically said "SCO isn't permitted to ask for it after
distributing it themselves".  Once that counterclaim is resolved, *then* we
will have a better precedent to cite (most likely changing "You can file suit
about it" into "You can file suit, but SCO v. IBM already said you can go stick
it in a pig, unless your lawyer can show how this case is *different* from SCO
v. IBM").  And that's the way the legal system works in the US - both sides
cite all the precedents they think support *their* view of the case, the
judge listens to all of them, and decides one of the following:

1) The case is basically the same as a precedent cited by one side or the other,
and therefor the ruling should be decided the same way.

2) The judge buys one side's claim that this is a *new* situation, and writes
a precedent-setting ruling for the situation.

3) Rarely, except in appelate courts, the judge will decide a prededent's
situation applies,  but that the previous judge got the ruling wrong, and
will overrule the prededent.  Most often, this happens when a lawyer cites
a precedent from a different "District" (the US is divided into a dozen or
so Districts, each of which has a semi-autonomous set of courts).  Occasionally,
the Supreme Court will take a case of the form "The Third District precedent
is this, and the Ninth Distric is that, and we need to know which one is
the Law of the Land".

And yes, every once in a while, a lawyer will even base a case on claiming
that a Supreme Court ruling is an incorrect precedent, usually by arguing
that the precedent was written in 1873, and that society has changed so much
that the ruling doesn't apply correctly anymore, or similar.

--==_Exmh_1159721335_8054P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFFH/F3cC3lWbTT17ARAvXAAKDWhV1A+wPAYszZxOlWkqbYLTXzfwCfe/yQ
sa6UHEnbUUAACXCnUdhfukU=
=lbF1
-----END PGP SIGNATURE-----

--==_Exmh_1159721335_8054P--
