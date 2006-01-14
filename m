Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751404AbWANNxn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751404AbWANNxn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 08:53:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751431AbWANNxm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 08:53:42 -0500
Received: from mout1.freenet.de ([194.97.50.132]:8685 "EHLO mout1.freenet.de")
	by vger.kernel.org with ESMTP id S1751404AbWANNxl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 08:53:41 -0500
From: Michael Buesch <mbuesch@freenet.de>
To: Chase Venters <chase.venters@clientec.com>
Subject: Re: wireless: recap of current issues (stack)
Date: Sat, 14 Jan 2006 14:51:14 +0100
User-Agent: KMail/1.8.3
References: <20060113195723.GB16166@tuxdriver.com> <20060113213200.GG16166@tuxdriver.com> <200601131703.29677.chase.venters@clientec.com>
In-Reply-To: <200601131703.29677.chase.venters@clientec.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       Jiri Benc <jbenc@suse.cz>, Stefan Rompf <stefan@loplof.de>,
       Mike Kershaw <dragorn@kismetwireless.net>,
       Krzysztof Halasa <khc@pm.waw.pl>, Robert Hancock <hancockr@shaw.ca>,
       Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       Dominik Brodowski <linux@dominikbrodowski.net>,
       Denis Vlasenko <vda@ilport.com.ua>,
       Danny van Dyk <kugelfang@gentoo.org>,
       Stephen Hemminger <shemminger@osdl.org>, feyd <feyd@nmskb.cz>,
       Andreas Mohr <andim2@users.sourceforge.net>,
       Bas Vermeulen <bvermeul@blackstar.nl>, Jean Tourrilhes <jt@hpl.hp.com>,
       Daniel Drake <dsd@gentoo.org>, Ulrich Kunitz <kune@deine-taler.de>,
       Phil Dibowitz <phil@ipom.com>, Simon Kelley <simon@thekelleys.org.uk>,
       Michael Buesch <mbuesch@freenet.de>,
       Marcel Holtmann <marcel@holtmann.org>,
       Patrick McHardy <kaber@trash.net>, Ingo Oeser <netdev@axxeo.de>,
       Harald Welte <laforge@gnumonks.org>,
       Ben Greear <greearb@candelatech.com>, Thomas Graf <tgraf@suug.ch>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2005014.11vCjguttJ";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200601141451.16232.mbuesch@freenet.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2005014.11vCjguttJ
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Saturday 14 January 2006 00:03, you wrote:
> As an aside to this whole thing, I know we're talking about *kernel* wire=
less=20
> but it's worthless to most people without good userland support as well.=
=20
> Anyone have any thoughts and feelings on what things look like on the=20
> desktop? I think if we work closely with some desktop people, we can shep=
ard=20
> in some wonderful new desktop support on top of the new netlink API.

I am in the KDE development and have (almost) full access to the KDE svn
repository. Altought I did not do much coding on KDE apps recently,
I will be able to help in WiFi support for KDE.
The first thing I thought of, was a tray icon with basic information
about the available interfaces and basic configuration
capabilities.

=2D-=20
Greetings Michael.

--nextPart2005014.11vCjguttJ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDyQHUlb09HEdWDKgRAkUaAKCgywqO8VjpQpxmdEozcA+Ha6qkxQCgmw6p
j/wIn14CKoIH2SsVE2UCeHc=
=SMKw
-----END PGP SIGNATURE-----

--nextPart2005014.11vCjguttJ--
