Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268279AbUHTQHX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268279AbUHTQHX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 12:07:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268255AbUHTQHW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 12:07:22 -0400
Received: from mx1.redhat.com ([66.187.233.31]:57735 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267363AbUHTQHG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 12:07:06 -0400
Date: Fri, 20 Aug 2004 18:06:05 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: Rik van Riel <riel@redhat.com>
Cc: Alan Cox <alan@redhat.com>, Oliver Neukum <oliver@neukum.org>,
       Pete Zaitcev <zaitcev@redhat.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Hugh Dickins <hugh@veritas.com>,
       greg@kroah.com, linux-kernel@vger.kernel.org, sct@redhat.com
Subject: Re: PF_MEMALLOC in 2.6
Message-ID: <20040820160605.GH19489@devserv.devel.redhat.com>
References: <20040820150257.GC6812@devserv.devel.redhat.com> <Pine.LNX.4.44.0408201204300.10373-100000@dhcp83-102.boston.redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hAW+M2+FUO+onfmf"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0408201204300.10373-100000@dhcp83-102.boston.redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--hAW+M2+FUO+onfmf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 20, 2004 at 12:04:51PM -0400, Rik van Riel wrote:
> On Fri, 20 Aug 2004, Alan Cox wrote:
> 
> > PF_MEMALLOC won't recurse. You might run out of memory however.
> 
> > Are any of the VM guys considering PF_LOGALLOC so you can trace it down 8)
> 
> No, but this thread does make me consider PF_NOIO ;)

given that the task of this thread is to DO io ... ;)


--hAW+M2+FUO+onfmf
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFBJiFsxULwo51rQBIRAhgoAJ4l9/sU2K7Q/OSEBfr52fhwq2HnsACgkSki
ul7SnoHE0ifTbIjtitAm344=
=Z3kC
-----END PGP SIGNATURE-----

--hAW+M2+FUO+onfmf--
