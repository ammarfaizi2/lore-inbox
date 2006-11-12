Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754090AbWKLIhJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754090AbWKLIhJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Nov 2006 03:37:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755014AbWKLIhJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Nov 2006 03:37:09 -0500
Received: from hansmi.home.forkbomb.ch ([213.144.146.165]:13597 "EHLO
	hansmi.home.forkbomb.ch") by vger.kernel.org with ESMTP
	id S1754090AbWKLIhH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Nov 2006 03:37:07 -0500
Date: Sun, 12 Nov 2006 09:37:05 +0100
From: Michael Hanselmann <linux-kernel@hansmi.ch>
To: Stelian Pop <stelian@popies.net>
Cc: Andrew Morton <akpm@osdl.org>, Dmitry Torokhov <dtor_core@ameritech.net>,
       "Aristeu S. Rozanski F." <aris@cathedrallabs.org>,
       Johannes Berg <johannes@sipsolutions.net>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Paul Mackerras <paulus@samba.org>, Robert Love <rml@novell.com>,
       Jean Delvare <khali@linux-fr.org>,
       Rene Nussbaumer <linux-kernel@killerfox.forkbomb.ch>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       nicolas@boichat.ch
Subject: Re: [PATCH] Apple Motion Sensor driver
Message-ID: <20061112083705.GB25609@hansmi.ch>
References: <1163280972.32084.13.camel@localhost.localdomain> <20061111214143.GA25609@hansmi.ch> <1163282417.32084.18.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1yeeQ81UyVL57Vl7"
Content-Disposition: inline
In-Reply-To: <1163282417.32084.18.camel@localhost.localdomain>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 11, 2006 at 11:00:17PM +0100, Stelian Pop wrote:
> > I've modified my driver to use an accelerometer class.=20

> Hmmm, I didn't know such a thing existed.

Yes, I wanted to keep a low profile because it would involve several
drivers. So I wanted to work out the basic class with Nicolas, whom I
added to Cc: and who's written the accelerator driver for the MacBooks,
and then contact the other maintainers. The idea was to have something
concrete, not just a concept to discuss.

But since Nicolas is really busy since months, I'd say the submitted
code can go in. I'll then make a patch which adds the class.

> I don't have a particular use for the accelerometer myself,

So do I, at least without the harddisk protection.

> I was just digging thru the pile of my local patches and I noticed
> that all the work (mine, yours and others) on the ams device seemed on
> its way to be lost, since nobody picked up the patch.

Yeah, I was waiting for Nicolas' answer again, so it got stuck here,
too.

Greets,
Michael

--1yeeQ81UyVL57Vl7
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFVt0x6J0saEpRu+oRAo+FAJ96+7GeNBSkkcUhP8LC1ShfwEjOEACfUdnf
f4LIUxXJBDja9EBJ1v4RRXg=
=1Jt8
-----END PGP SIGNATURE-----

--1yeeQ81UyVL57Vl7--
