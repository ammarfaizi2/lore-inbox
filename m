Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264954AbUAZIfv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 03:35:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265100AbUAZIfv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 03:35:51 -0500
Received: from Hell.WH8.tu-dresden.de ([141.30.225.3]:52655 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id S264954AbUAZIfs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 03:35:48 -0500
Date: Mon, 26 Jan 2004 09:35:22 +0100
From: "Udo A. Steinberg" <us15@os.inf.tu-dresden.de>
To: Hugang <hugang@soulinfo.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [OOPS] Linux-2.6.1 suspend/resume
Message-Id: <20040126093522.3731d69b@argon.inf.tu-dresden.de>
In-Reply-To: <20040126121632.70097914@localhost>
References: <20040126022540.315c4f8c@argon.inf.tu-dresden.de>
	<20040126121632.70097914@localhost>
Organization: Fiasco Core Team
X-GPG-Key: 1024D/233B9D29 (wwwkeys.pgp.net)
X-GPG-Fingerprint: CE1F 5FDD 3C01 BE51 2106 292E 9E14 735D 233B 9D29
X-Mailer: X-Mailer 5.0 Gold
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Mon__26_Jan_2004_09_35_22_+0100_weyqKp0PKn=Aqkv+"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Mon__26_Jan_2004_09_35_22_+0100_weyqKp0PKn=Aqkv+
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Mon, 26 Jan 2004 12:16:31 +0800 Hugang (H) wrote:

H> I think if you can let usb, e100 as module, before suspend rmmod it, 
H> resume will be ok.
H> 
H> pls try.

The kernel is monolithic. I'm not using any modules.

-Udo.

--Signature=_Mon__26_Jan_2004_09_35_22_+0100_weyqKp0PKn=Aqkv+
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFAFNFKnhRzXSM7nSkRApT4AJ9SwkwibOJkAmcQ9ghmnrUEgetEaQCeMy5l
u8askq4UJBNdcdBnkCfLGTk=
=9QER
-----END PGP SIGNATURE-----

--Signature=_Mon__26_Jan_2004_09_35_22_+0100_weyqKp0PKn=Aqkv+--
