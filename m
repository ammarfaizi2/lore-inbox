Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266858AbUHCVZY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266858AbUHCVZY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 17:25:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266867AbUHCVZY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 17:25:24 -0400
Received: from mx1.redhat.com ([66.187.233.31]:54715 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266858AbUHCVZT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 17:25:19 -0400
Date: Tue, 3 Aug 2004 23:24:26 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Rik van Riel <riel@redhat.com>, Chris Wright <chrisw@osdl.org>,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [patch] mlock-as-nonroot revisted
Message-ID: <20040803212426.GA5113@devserv.devel.redhat.com>
References: <20040803210737.GI2241@dualathlon.random> <Pine.LNX.4.44.0408031712371.5948-100000@dhcp83-102.boston.redhat.com> <20040803212231.GJ2241@dualathlon.random>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RnlQjJ0d97Da+TV1"
Content-Disposition: inline
In-Reply-To: <20040803212231.GJ2241@dualathlon.random>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 03, 2004 at 11:22:31PM +0200, Andrea Arcangeli wrote:
> 
> I agree there aren't security issues, but it's still very wrong to
> charge the old user if the admin gives the locked ram to a new user.

no he gives the FILE to the new user.
Which 1) is rare and 2) doesn't mean the old user stopped using it

--RnlQjJ0d97Da+TV1
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFBEAKJxULwo51rQBIRAv31AJ0bdFdctHAlIxQrw3jwLxS9Z3XAfwCcCRZB
vtkHlF3OXp+x7N6c4pdlGmA=
=Srs4
-----END PGP SIGNATURE-----

--RnlQjJ0d97Da+TV1--
