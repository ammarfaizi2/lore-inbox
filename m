Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266202AbUALPNl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 10:13:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266198AbUALPNk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 10:13:40 -0500
Received: from mx1.redhat.com ([66.187.233.31]:14980 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266144AbUALPMs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 10:12:48 -0500
Date: Mon, 12 Jan 2004 16:12:30 +0100
From: Arjan van de Ven <arjanv@redhat.com>
To: Martin Peschke3 <MPESCHKE@de.ibm.com>
Cc: Jens Axboe <axboe@suse.de>, Doug Ledford <dledford@redhat.com>,
       Peter Yao <peter@exavio.com.cn>, linux-kernel@vger.kernel.org,
       linux-scsi mailing list <linux-scsi@vger.kernel.org>, ihno@suse.de
Subject: Re: smp dead lock of io_request_lock/queue_lock patch
Message-ID: <20040112151230.GB5844@devserv.devel.redhat.com>
References: <OF317B32D5.C8C681CB-ONC1256E19.005066CF-C1256E19.00538DEF@de.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UHN/qo2QbUvPLonB"
Content-Disposition: inline
In-Reply-To: <OF317B32D5.C8C681CB-ONC1256E19.005066CF-C1256E19.00538DEF@de.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--UHN/qo2QbUvPLonB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 12, 2004 at 04:07:40PM +0100, Martin Peschke3 wrote:
> as the patch discussed in this thread, i.e. pure (partially
> vintage) bugfixes.

Both SuSE and Red Hat submit bugfixes they put in the respective trees to
marcelo already. There will not be many "pure bugfixes" that you can find in
vendor trees but not in marcelo's tree.

> If people agree in that course also about a clean, common
> iorl-patch, that would be another step forward, in my opinion.

None of the vendors in question is still doing development based on 2.4 (in
fact I suspect no linux vendor/distro still is) so if you want vendors to go
to a joint patch for such a specific enhancement, which WILL include
development, I really don't see the point. Neither SuSE nor Red Hat will be
jumping from joy to do a lot of work to replace a patch that works in their
respective existing products with something else with no clear gain at all,
while requiring significant work and stability risks.

Greetings,
    Arjan van de Ven

--UHN/qo2QbUvPLonB
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFAArldxULwo51rQBIRAiW9AJoCsHnL+pXD+m3kJ/2lJdAF3BObNwCbBlWg
sNc5hxtqMGQk7YSZUm/zUUs=
=PLYe
-----END PGP SIGNATURE-----

--UHN/qo2QbUvPLonB--
