Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267602AbUG2Q3W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267602AbUG2Q3W (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 12:29:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267482AbUG2Q10
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 12:27:26 -0400
Received: from mx1.redhat.com ([66.187.233.31]:13720 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267716AbUG2QYq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 12:24:46 -0400
Date: Thu, 29 Jul 2004 18:23:55 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: Chris Caputo <ccaputo@alt.net>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org
Subject: Re: inode_unused list corruption in 2.4.26 - spin_lock problem?
Message-ID: <20040729162354.GA26891@devserv.devel.redhat.com>
References: <20040729122107.GA1024@devserv.devel.redhat.com> <Pine.LNX.4.44.0407290909410.30975-100000@nacho.alt.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gBBFr7Ir9EOA20Yy"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0407290909410.30975-100000@nacho.alt.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


On Thu, Jul 29, 2004 at 09:22:40AM -0700, Chris Caputo wrote:
> 
> Should I try the run-once/oneshot feature of irqbalance on boot, and then
> leave it off and see if anything happens?

that sounds like a good test

it really smells that a certain distribution of irq's is causing you grief
more than the actual changing...

--gBBFr7Ir9EOA20Yy
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFBCSSaxULwo51rQBIRApQ5AJ4vorrgZT2fefeQIhutx514vCYNgwCgmj9n
ewnsYMaxuETUmeEe/gI7JuQ=
=0IEt
-----END PGP SIGNATURE-----

--gBBFr7Ir9EOA20Yy--
