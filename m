Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265510AbUF2G6a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265510AbUF2G6a (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 02:58:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265516AbUF2G6a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 02:58:30 -0400
Received: from mx1.redhat.com ([66.187.233.31]:58553 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265510AbUF2G61 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 02:58:27 -0400
Date: Tue, 29 Jun 2004 08:55:37 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: davidm@hpl.hp.com
Cc: Jeff Garzik <jgarzik@pobox.com>, Terence Ripperda <tripperda@nvidia.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 32-bit dma allocations on 64-bit platforms
Message-ID: <20040629065537.GB2898@devserv.devel.redhat.com>
References: <20040623183535.GV827@hygelac> <40D9D7BA.7020702@pobox.com> <16605.1055.383447.805653@napali.hpl.hp.com> <1088234187.2805.3.camel@laptop.fenrus.com> <16609.2168.754171.270072@napali.hpl.hp.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eAbsdosE1cNLO4uF"
Content-Disposition: inline
In-Reply-To: <16609.2168.754171.270072@napali.hpl.hp.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--eAbsdosE1cNLO4uF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 28, 2004 at 11:13:12PM -0700, David Mosberger wrote:
> >>>>> On Sat, 26 Jun 2004 09:16:27 +0200, Arjan van de Ven <arjanv@redhat.com> said:
> 
>   Arjan> the real solution is an iommu of course, but the highmem
>   Arjan> solution has quite some merit too..... I know you disagree
>   Arjan> with me on that one though.
> 
> Yes, some merits and some faults.  The real solution is iommu or
> 64-bit capable devices.  Interesting that graphics controllers should
> be last to get 64-bit DMA capability, considering how much more
> complex they are than disk controllers or NICs.

I guess the first game with more than 4Gb in textures will fix it ;)


--eAbsdosE1cNLO4uF
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFA4RJpxULwo51rQBIRApo4AJ9rQlfusjI7k6/DyWAs3C8/saKKGACghOBR
qGkHali4sQFF03PrPGMib/Q=
=gH/n
-----END PGP SIGNATURE-----

--eAbsdosE1cNLO4uF--
