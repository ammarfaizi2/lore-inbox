Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268541AbUI2PGM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268541AbUI2PGM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 11:06:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268592AbUI2PFi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 11:05:38 -0400
Received: from mx1.redhat.com ([66.187.233.31]:5801 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268541AbUI2PCJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 11:02:09 -0400
Date: Wed, 29 Sep 2004 17:01:48 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: Andrea Arcangeli <andrea@novell.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: heap-stack-gap for 2.6
Message-ID: <20040929150148.GA14722@devserv.devel.redhat.com>
References: <20040925162252.GN3309@dualathlon.random> <1096272553.6572.3.camel@laptop.fenrus.com> <20040927130919.GE28865@dualathlon.random> <20040928194351.GC5037@devserv.devel.redhat.com> <20040928221933.GG4084@dualathlon.random> <20040929060521.GA6975@devserv.devel.redhat.com> <20040929141151.GJ4084@dualathlon.random> <20040929142521.GB22928@devserv.devel.redhat.com> <20040929145344.GA22008@dualathlon.random>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TB36FDmn/VVEgNH/"
Content-Disposition: inline
In-Reply-To: <20040929145344.GA22008@dualathlon.random>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 29, 2004 at 04:53:44PM +0200, Andrea Arcangeli wrote:
> > I am aware of 2 applications breaking. Both did
> 
> oh, so you see, I wasn't *that* wrong if you're already aware of 2 apps
> breaking.

and you would have known it too if you had looked up the changeset that
implemented flex mmap since it was documented there.


--TB36FDmn/VVEgNH/
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFBWs5cxULwo51rQBIRAklHAJ9usy3DQRse0Vx3YWx77i2HayulQgCfaVp3
mIKWbV8KdTUFBWMNNyvd6GM=
=8CSf
-----END PGP SIGNATURE-----

--TB36FDmn/VVEgNH/--
