Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263756AbUE1RrR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263756AbUE1RrR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 13:47:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263763AbUE1RrQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 13:47:16 -0400
Received: from mx1.redhat.com ([66.187.233.31]:20625 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263756AbUE1RrM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 13:47:12 -0400
Date: Fri, 28 May 2004 19:45:46 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "Nakajima, Jun" <jun.nakajima@intel.com>, Andrew Morton <akpm@osdl.org>,
       Anton Blanchard <anton@samba.org>, linux-kernel@vger.kernel.org
Subject: Re: CONFIG_IRQBALANCE for AMD64?
Message-ID: <20040528174546.GA9898@devserv.devel.redhat.com>
References: <7F740D512C7C1046AB53446D372001730182BAE2@scsmsx402.amr.corp.intel.com> <40B7797F.2090204@pobox.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PEIAKu/WMn1b1Hv9"
Content-Disposition: inline
In-Reply-To: <40B7797F.2090204@pobox.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 28, 2004 at 01:40:15PM -0400, Jeff Garzik wrote:
> kirqd.  From a hard-numbers perspective, compared to kirqd, the userland 
> solution is still largely an unknown quantity.

unfortionately I have no publishable benchmarks ;( Doesn't mean it's an
unknown; all specweb and TPC benchmarks done with RHEL3 are with it for
example.

--PEIAKu/WMn1b1Hv9
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFAt3rJxULwo51rQBIRAkcFAJ96UeYtzL76v6a1B5/O+vZ/4FkcnQCfU0xQ
XAB+VuYV3PSst5S/beKQ414=
=P0ar
-----END PGP SIGNATURE-----

--PEIAKu/WMn1b1Hv9--
