Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266161AbUGJGdH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266161AbUGJGdH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 02:33:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266163AbUGJGdH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 02:33:07 -0400
Received: from mx1.redhat.com ([66.187.233.31]:53419 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266161AbUGJGdE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 02:33:04 -0400
Date: Sat, 10 Jul 2004 08:32:22 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Christoph Hellwig <hch@infradead.org>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
Subject: Re: [announce] [patch] Voluntary Kernel Preemption Patch
Message-ID: <20040710063222.GB8267@devserv.devel.redhat.com>
References: <20040709182638.GA11310@elte.hu> <20040709195105.GA4807@infradead.org> <20040709235017.GP20947@dualathlon.random>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="A6N2fC+uXW/VQSAv"
Content-Disposition: inline
In-Reply-To: <20040709235017.GP20947@dualathlon.random>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--A6N2fC+uXW/VQSAv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jul 10, 2004 at 01:50:17AM +0200, Andrea Arcangeli wrote:
> the other bad thing is that there is no  point for the sysctl (in 2.4
> that made no sense at all too, yeah it only makes sense for benchmarking
> easily w/ and w/o the feature but it must be optimized away at the very
> least with a config option for production), 

as Ingo wrote, that is the plan, all that "crud" is there just to make it
easy to benchmark for now.

--A6N2fC+uXW/VQSAv
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFA7412xULwo51rQBIRAp10AJ4nRTH73Rf5FW4y/I4rs/uvCZXfOwCdGJc1
T1xifItpZvpLIwsbSJ4Xvts=
=Erjh
-----END PGP SIGNATURE-----

--A6N2fC+uXW/VQSAv--
