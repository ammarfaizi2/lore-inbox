Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266186AbUGOMdK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266186AbUGOMdK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jul 2004 08:33:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266188AbUGOMdK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jul 2004 08:33:10 -0400
Received: from mx1.redhat.com ([66.187.233.31]:15563 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266186AbUGOMdC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jul 2004 08:33:02 -0400
Date: Thu, 15 Jul 2004 14:31:51 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: Paul Jakma <paul@clubi.ie>
Cc: christophe.varoqui@free.fr, dm-devel@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: namespaces (was Re: [Q] don't allow tmpfs to page out)
Message-ID: <20040715123148.GA23112@devserv.devel.redhat.com>
References: <1089878317.40f6392d7e365@imp5-q.free.fr> <20040715080017.GB20889@devserv.devel.redhat.com> <Pine.LNX.4.60.0407151329100.2622@fogarty.jakma.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RnlQjJ0d97Da+TV1"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.60.0407151329100.2622@fogarty.jakma.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 15, 2004 at 01:31:08PM +0100, Paul Jakma wrote:
> On Thu, 15 Jul 2004, Arjan van de Ven wrote:
> 
> >sure; namespaces can do a LOT
> 
> speaking of which, how does one use namespaces exactly? The kernel 
> appears to maintain mount information per process, but how do you set 
> this up?
> 
> neither 'man mount/namespace' nor 'appropos namespace' show up 
> anything.

it's a clone() flag....

--RnlQjJ0d97Da+TV1
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFA9nk0xULwo51rQBIRAtAnAJsGc1In6DEGNXJMfdenWV60rH48fQCbBk0i
YyOHIyOG34MW1BblRplvSfM=
=eFrb
-----END PGP SIGNATURE-----

--RnlQjJ0d97Da+TV1--
