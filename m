Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263544AbUAFOYT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 09:24:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264353AbUAFOYT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 09:24:19 -0500
Received: from ns.suse.de ([195.135.220.2]:31943 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263544AbUAFOYO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 09:24:14 -0500
Date: Tue, 6 Jan 2004 15:24:12 +0100
From: Kurt Garloff <kurt@garloff.de>
To: Nick Craig-Wood <ncw1@axis.demon.co.uk>
Cc: Linux kernel list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0 Huge pages not working as expected
Message-ID: <20040106142412.GN3248@tpkurt.garloff.de>
Mail-Followup-To: Kurt Garloff <kurt@garloff.de>,
	Nick Craig-Wood <ncw1@axis.demon.co.uk>,
	Linux kernel list <linux-kernel@vger.kernel.org>
References: <20031226105433.GA25970@axis.demon.co.uk> <20031226115647.GH27687@holomorphy.com> <20031226201011.GA32316@axis.demon.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TXIPBuAs4GDcsx9K"
Content-Disposition: inline
In-Reply-To: <20031226201011.GA32316@axis.demon.co.uk>
User-Agent: Mutt/1.4.1i
X-Operating-System: Linux 2.4.21-166-default i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: SUSE(DE), TU/e(NL)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--TXIPBuAs4GDcsx9K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 26, 2003 at 08:10:11PM +0000, Nick Craig-Wood wrote:
> (Interesting note - the 700 MHz P3 laptop is nearly twice as fast as
> the 1.7 GHx P4 dekstop (261ms vs 489ms) at the span 4096 case, but the
> P4 beats the P3 by a factor of 23 for the stride 1 (3ms vs 71 ms)!)

The factor is 6.2 (11.5ms vs 71ms), which is 2 * 1700/550.
Still impressive: P4 is doing twice the work per cycle compared to PIII.

Regards,
--=20
Kurt Garloff                   <kurt@garloff.de>             [Koeln, DE]
Physics:Plasma modeling <garloff@plasimo.phys.tue.nl> [TU Eindhoven, NL]
Linux:SCSI, Security           <garloff@suse.de>    [SUSE Nuernberg, DE]

--TXIPBuAs4GDcsx9K
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/+sUMxmLh6hyYd04RAjyuAJ4rdI4KefyFzO13TBzgIN0f+avzKACfQwcU
5hmhltVuGCJvRCtpHYLnSFo=
=TS70
-----END PGP SIGNATURE-----

--TXIPBuAs4GDcsx9K--
