Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262488AbUCPPJ6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 10:09:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262609AbUCPPJ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 10:09:56 -0500
Received: from ns.suse.de ([195.135.220.2]:19873 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262450AbUCPPIq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 10:08:46 -0500
Date: Tue, 16 Mar 2004 16:08:08 +0100
From: Kurt Garloff <garloff@suse.de>
To: Timothy Miller <miller@techsource.com>
Cc: Linux kernel list <linux-kernel@vger.kernel.org>
Subject: Re: dynamic sched timeslices
Message-ID: <20040316150808.GB4452@tpkurt.garloff.de>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Timothy Miller <miller@techsource.com>,
	Linux kernel list <linux-kernel@vger.kernel.org>
References: <20040315224201.GX4452@tpkurt.garloff.de> <4057174B.3050305@techsource.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WCiRD21tF6xAtlSs"
Content-Disposition: inline
In-Reply-To: <4057174B.3050305@techsource.com>
X-Operating-System: Linux 2.6.4-1-KG i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: SUSE/Novell
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--WCiRD21tF6xAtlSs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Timothy,

On Tue, Mar 16, 2004 at 10:03:39AM -0500, Timothy Miller wrote:
> If this doesn't change the total amount of CPU a process can get but=20
> lets a process tweak how its CPU time is divided up, then it sounds=20
> wonderful.

It let's the sysadming tune how often the kernel switches between=20
processes competing for the CPU.

Regards,
--=20
Kurt Garloff  <garloff@suse.de>                            Cologne, DE=20
SUSE LINUX AG, Nuernberg, DE                          SUSE Labs (Head)

--WCiRD21tF6xAtlSs
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFAVxhYxmLh6hyYd04RAg9HAKDBxOuO1mEN8WUbUid7i9V59WVStACgwbze
TRpjpE3TUpzXO8xiywjGijg=
=pOxh
-----END PGP SIGNATURE-----

--WCiRD21tF6xAtlSs--
