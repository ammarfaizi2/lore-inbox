Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266290AbUGJPPa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266290AbUGJPPa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 11:15:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266291AbUGJPPa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 11:15:30 -0400
Received: from mx1.redhat.com ([66.187.233.31]:994 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266290AbUGJPP2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 11:15:28 -0400
Date: Sat, 10 Jul 2004 17:14:55 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: Con Kolivas <kernel@kolivas.org>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: [announce] [patch] Voluntary Kernel Preemption Patch
Message-ID: <20040710151455.GA29140@devserv.devel.redhat.com>
References: <20040709182638.GA11310@elte.hu> <20040709195105.GA4807@infradead.org> <20040710124814.GA27345@elte.hu> <40F0075C.2070607@kolivas.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gBBFr7Ir9EOA20Yy"
Content-Disposition: inline
In-Reply-To: <40F0075C.2070607@kolivas.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jul 11, 2004 at 01:12:28AM +1000, Con Kolivas wrote:
> I've conducted some of the old fashioned Benno's latency test on this 

is that the test which skews with irq's disabled ? (eg uses normal
interrupts and not nmi's for it's initial time inrq)

--gBBFr7Ir9EOA20Yy
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFA8AfuxULwo51rQBIRAu96AKCb2ffKp/YUeBr7jsi1booDoaKTuACgpqww
WUIiwFJHLVt7+sd5txp++9A=
=iA86
-----END PGP SIGNATURE-----

--gBBFr7Ir9EOA20Yy--
