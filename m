Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318649AbSH1Dxt>; Tue, 27 Aug 2002 23:53:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318661AbSH1Dxt>; Tue, 27 Aug 2002 23:53:49 -0400
Received: from ppp-217-133-221-76.dialup.tiscali.it ([217.133.221.76]:29318
	"EHLO home.ldb.ods.org") by vger.kernel.org with ESMTP
	id <S318649AbSH1Dxs>; Tue, 27 Aug 2002 23:53:48 -0400
Subject: Re: Bug in kernel code?
From: Luca Barbieri <ldb@ldb.ods.org>
To: "David S. Miller" <davem@redhat.com>
Cc: s.biggs@softier.com, Linux-Kernel ML <linux-kernel@vger.kernel.org>
In-Reply-To: <20020827.203946.102043898.davem@redhat.com>
References: <3D6BC3CD.10889.6526BC@localhost>
	<20020827.182312.52750220.davem@redhat.com> <3D6BD62C.581.ACEBAD@localhost>
	 <20020827.203946.102043898.davem@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-+ou7+NDpoTmba5coq43n"
X-Mailer: Ximian Evolution 1.0.5 
Date: 28 Aug 2002 05:57:50 +0200
Message-Id: <1030507070.1489.32.camel@ldb>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-+ou7+NDpoTmba5coq43n
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, 2002-08-28 at 05:39, David S. Miller wrote:
>    From: "Stephen C. Biggs" <s.biggs@softier.com>
>    Date: Tue, 27 Aug 2002 19:42:36 -0700
> 
>    How about (unsigned long)(~0)?
>    
> Realistically possible with any known configuration?
How about replacing the loop with ffs/__ffs that would be more elegant,
shorter and avoid any problem or doubt?


--=-+ou7+NDpoTmba5coq43n
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA9bEo+djkty3ft5+cRAkbSAJ4muF+dpiJeJcTjt2UhG02ESx8S7ACeJ73D
uG+njqVB+Z8OkMkGzEkzfyQ=
=ChXw
-----END PGP SIGNATURE-----

--=-+ou7+NDpoTmba5coq43n--
