Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265168AbUAEQ52 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 11:57:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265170AbUAEQ52
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 11:57:28 -0500
Received: from kiuru.kpnet.fi ([193.184.122.21]:1204 "EHLO kiuru.kpnet.fi")
	by vger.kernel.org with ESMTP id S265168AbUAEQ5Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 11:57:25 -0500
Subject: Re: linux-2.4.24 released
From: Markus =?ISO-8859-1?Q?H=E4stbacka?= <midian@ihme.org>
To: Marcelo Tosatti <marcelo@hera.kernel.org>
Cc: Kernel Mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <200401051355.i05DtvgC020415@hera.kernel.org>
References: <200401051355.i05DtvgC020415@hera.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-vjLvNlniJ6+XpER/SngU"
Message-Id: <1073321792.21338.2.camel@midux>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 05 Jan 2004 18:56:32 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-vjLvNlniJ6+XpER/SngU
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

make modules_install fails with the following errors:

depmod: *** Unresolved symbols in
/lib/modules/2.4.24/kernel/drivers/net/dummy.o
depmod:         dev_alloc_name_R96db38a6
depmod:         kmalloc_R93d4cfe6
depmod:         ether_setup_R0309250f
depmod:         unregister_netdev_Rbe3cfced
depmod:         kfree_R037a0cba
depmod:         __kfree_skb_R934b4bff
depmod:         register_netdev_R7378c15b
depmod: *** Unresolved symbols in
/lib/modules/2.4.24/kernel/drivers/net/shaper.o
depmod:         skb_clone_Rec5f0f23
depmod:         arp_broken_ops_R5494f366
depmod:         mod_timer_R1f13d309
depmod:         irq_stat_Rd267df73
depmod:         dev_alloc_name_R96db38a6
depmod:         kmalloc_R93d4cfe6
depmod:         dev_queue_xmit_R95582748
depmod:         jiffies_R0da02d67
depmod:         unregister_netdev_Rbe3cfced
depmod:         __wake_up_Rb76c5f1e
depmod:         del_timer_Rfc62f16d
depmod:         __dev_get_by_name_R14ac47be
depmod:         kfree_R037a0cba
depmod:         sleep_on_Re0679a3f
depmod:         printk_R1b7d4074
depmod:         __kfree_skb_R934b4bff
depmod:         register_netdev_R7378c15b
make: *** [_modinst_post] Error 1

Regards,
Markus.
--=20
"Software is like sex, it's better when it's free."
Markus H=E4stbacka <midian at ihme dot org>

--=-vjLvNlniJ6+XpER/SngU
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQA/+ZdA3+NhIWS1JHARAj4WAKCMdvnuQmK2N6s0l1xm7DmwtjTfCwCff9Nf
oW0onE4opCxAKR3DQtcnfQM=
=DHPi
-----END PGP SIGNATURE-----

--=-vjLvNlniJ6+XpER/SngU--

