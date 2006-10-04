Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030572AbWJDQNK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030572AbWJDQNK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 12:13:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030422AbWJDQNK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 12:13:10 -0400
Received: from systemlinux.org ([83.151.29.59]:8623 "EHLO m18s25.vlinux.de")
	by vger.kernel.org with ESMTP id S1030615AbWJDQNI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 12:13:08 -0400
Date: Wed, 4 Oct 2006 18:12:54 +0200
From: Andre Noll <maan@systemlinux.org>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, andrea@suse.de, riel@redhat.com
Subject: Re: 2.6.18: Kernel BUG at mm/rmap.c:522
Message-ID: <20061004161254.GE22487@skl-net.de>
References: <20061004104018.GB22487@skl-net.de> <4523BE45.5050205@yahoo.com.au> <20061004154227.GD22487@skl-net.de> <1159976940.27331.0.camel@twins>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zaRBsRFn0XYhEU69"
Content-Disposition: inline
In-Reply-To: <1159976940.27331.0.camel@twins>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--zaRBsRFn0XYhEU69
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 17:49, Peter Zijlstra wrote:

> enable CONFIG_DEBUG_VM to get that.

Yup, that was disabled. It's enabled now.

Thanks
Andre

--=20
The only person who always got his work done by Friday was Robinson Crusoe

--zaRBsRFn0XYhEU69
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFFI92GWto1QDEAkw8RAmUHAJ9BxUxT/eVyHfx2hT5ZDEyMirnhTQCfU0HR
JOOgzODwzqTNhlOoKLLmOYM=
=BXVh
-----END PGP SIGNATURE-----

--zaRBsRFn0XYhEU69--
