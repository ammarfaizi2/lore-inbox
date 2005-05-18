Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262166AbVERLbo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262166AbVERLbo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 07:31:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262176AbVERLbn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 07:31:43 -0400
Received: from nysv.org ([213.157.66.145]:3715 "EHLO nysv.org")
	by vger.kernel.org with ESMTP id S262166AbVERLbk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 07:31:40 -0400
Date: Wed, 18 May 2005 14:30:16 +0300
To: Carlos Carvalho <carlos@fisica.ufpr.br>
Cc: Con Kolivas <kernel@kolivas.org>, AndrewMorton <akpm@osdl.org>,
       ck@vds.kolivas.org, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
Subject: Re: [SMP NICE] [PATCH] SCHED: Implement nice support across physical cpus on SMP
Message-ID: <20050518113016.GL1399@nysv.org>
References: <20050509112446.GZ1399@nysv.org> <17023.63512.319555.552924@fisica.ufpr.br> <200505111304.06853.kernel@kolivas.org> <200505162133.13399.kernel@kolivas.org> <17033.62480.218289.246488@fisica.ufpr.br>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="quhRrEslxwodne78"
Content-Disposition: inline
In-Reply-To: <17033.62480.218289.246488@fisica.ufpr.br>
User-Agent: Mutt/1.5.6+20040907i
From: mjt@nysv.org (Markus  =?ISO-8859-1?Q?=20T=F6rnqvist?=)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--quhRrEslxwodne78
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 17, 2005 at 10:39:28AM -0300, Carlos Carvalho wrote:
>That's a pity. What's more important however is that this misfeature
>of the scheduler should be corrected ASAP. The nice control is a
>traditional UNIX characteristic and it should have higher priority in
>the patch inclusion queue than other scheduler improvements.

Linux is not a traditional unix, but it doesn't mean the support
shouldn't exist.

My suggestion is that whoever broke the interface, rendering
con's patch which mingo accepted useless, merge the patch.

Thanks!

--=20
mjt


--quhRrEslxwodne78
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFCiydIIqNMpVm8OhwRAohhAJoDWa4KnRhYKvvrJD8PBT9K8d6LgACgi9HQ
MXIecUEh18g7Zu0o97Vg2ek=
=lSuI
-----END PGP SIGNATURE-----

--quhRrEslxwodne78--
