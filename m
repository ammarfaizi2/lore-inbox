Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267082AbSKVJPx>; Fri, 22 Nov 2002 04:15:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267099AbSKVJPx>; Fri, 22 Nov 2002 04:15:53 -0500
Received: from 81-5-136-19.dsl.eclipse.net.uk ([81.5.136.19]:18692 "EHLO
	vlad.carfax.org.uk") by vger.kernel.org with ESMTP
	id <S267082AbSKVJPw>; Fri, 22 Nov 2002 04:15:52 -0500
Date: Fri, 22 Nov 2002 09:22:41 +0000
From: Hugo Mills <hugo-lkml@carfax.org.uk>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Max Valdez <maxvaldez@yahoo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Too muxh paging with 2.4.20-rc2-ac1
Message-ID: <20021122092241.GA1138@carfax.org.uk>
Mail-Followup-To: Hugo Mills <hugo-lkml@carfax.org.uk>,
	Rik van Riel <riel@conectiva.com.br>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Max Valdez <maxvaldez@yahoo.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1037891119.7845.18.camel@irongate.swansea.linux.org.uk> <Pine.LNX.4.44L.0211212204270.4103-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/9DWx/yDrRhgMJTb"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L.0211212204270.4103-100000@imladris.surriel.com>
User-Agent: Mutt/1.4i
x-gpg-fingerprint: B997 A9F1 782D D1FD 9F87  5542 B2C2 7BC2 1C33 5860
x-gpg-key: 1C335860
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 21, 2002 at 10:05:43PM -0200, Rik van Riel wrote:
> On 21 Nov 2002, Alan Cox wrote:
> 
> > The latest -ac has Rik's newer rmap code. It seems to have a few
> > problems so I may back it out again soon until Rik figures out the
> > problem
> 
> There are no functional changes in the batch of small patches
> I sent you last week.

   That may be the case, but whatever Alan changed between -rc1-ac3
and -rc2-ac3 seems to fix the same problem for me.

   Thanks,
   Hugo.

-- 
=== Hugo Mills: hugo@... carfax.org.uk | darksatanic.net | lug.org.uk ===
 PGP: 1024D/1C335860 from wwwkeys.eu.pgp.net or www.carfax.nildram.co.uk
           --- I must be musical:  I've got *loads* of CDs ---           

--/9DWx/yDrRhgMJTb
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE93fdhssJ7whwzWGARAmFDAKCNwEWog0292nTlEfRgRKpXrBL94QCgrglm
haP+PKGRzMn9u3wOj4UrUOc=
=VYAh
-----END PGP SIGNATURE-----

--/9DWx/yDrRhgMJTb--
