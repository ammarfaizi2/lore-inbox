Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130347AbQKOLsR>; Wed, 15 Nov 2000 06:48:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130352AbQKOLsE>; Wed, 15 Nov 2000 06:48:04 -0500
Received: from lacrosse.corp.redhat.com ([207.175.42.154]:10319 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S130347AbQKOLrt>; Wed, 15 Nov 2000 06:47:49 -0500
Date: Wed, 15 Nov 2000 11:17:47 +0000
From: Tim Waugh <twaugh@redhat.com>
To: Olaf Titz <olaf@bigred.inka.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: More modutils: It's probably worse.
Message-ID: <20001115111747.I18112@redhat.com>
In-Reply-To: <8us4ji$dbl$1@cesium.transmeta.com> <11900.974244463@ocs3.ocs-net> <E13w02k-000172-00@g212.hadiko.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="7EcdJGVUOqBBKNlB"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E13w02k-000172-00@g212.hadiko.de>; from olaf@bigred.inka.de on Wed, Nov 15, 2000 at 11:43:54AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--7EcdJGVUOqBBKNlB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 15, 2000 at 11:43:54AM +0100, Olaf Titz wrote:

> > plus the
> > modprobe meta expansion algorithm.
>=20
> and I see no reason why modprobe should do any such thing, apart from
> configurations dealt with in modules.conf anyway.

If it helps, wordexp has a flag to prevent command substitutions from
occuring.

Tim.
*/

--7EcdJGVUOqBBKNlB
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6EnDaONXnILZ4yVIRAuJfAJ4+F6xZCOim5pSDDd2mVkeCPrltDACePZBY
7xTd/t3wYe1qLUhpf2Y1PNg=
=7VMu
-----END PGP SIGNATURE-----

--7EcdJGVUOqBBKNlB--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
