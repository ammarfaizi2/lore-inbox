Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267431AbUGNQFE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267431AbUGNQFE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 12:05:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267432AbUGNQFD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 12:05:03 -0400
Received: from mx1.redhat.com ([66.187.233.31]:18116 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267431AbUGNQE6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 12:04:58 -0400
Date: Wed, 14 Jul 2004 18:04:21 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: Michael Buesch <mbuesch@freenet.de>
Cc: William Stearns <wstearns@pobox.com>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [Q] don't allow tmpfs to page out
Message-ID: <20040714160421.GD22641@devserv.devel.redhat.com>
References: <200407141654.31817.mbuesch@freenet.de> <200407141751.14292.mbuesch@freenet.de> <1089820882.2806.7.camel@laptop.fenrus.com> <200407141803.21388.mbuesch@freenet.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="W5WqUoFLvi1M7tJE"
Content-Disposition: inline
In-Reply-To: <200407141803.21388.mbuesch@freenet.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--W5WqUoFLvi1M7tJE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 14, 2004 at 06:03:18PM +0200, Michael Buesch wrote:
> > 
> > which is why there is ramfs .. :)
> 
> In 2.4, too? Can't find it.
> What's the CONFIG_* of ramfs?

CONFIG_RAMFS


--W5WqUoFLvi1M7tJE
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFA9VmExULwo51rQBIRAn/1AKCcCieODtlp8Ggv8/qh6yx2rkR2NwCfVVBM
ZsuHbacOqxM24TGri1YrkIc=
=/3oq
-----END PGP SIGNATURE-----

--W5WqUoFLvi1M7tJE--
