Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262008AbTFZNfX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jun 2003 09:35:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262013AbTFZNfW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jun 2003 09:35:22 -0400
Received: from emuzed.temp.veriohosting.com ([161.58.152.119]:5125 "EHLO
	emuzed.temp.veriohosting.com") by vger.kernel.org with ESMTP
	id S262008AbTFZNfP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jun 2003 09:35:15 -0400
Date: Thu, 26 Jun 2003 19:26:30 +0530
From: John Navil Joseph <navil@emuzed.com>
To: linux-kernel@vger.kernel.org
Subject: Why zap_page_ranges() not exported..?
Message-ID: <20030626135630.GA1738@EMB>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="u3/rZRmxL6MmkK24"
Content-Disposition: inline
User-Agent: Mutt/1.4i
Organization: Emuzed India Private Limited.
X-Operating-System: Red Hat GNU/Linux 9.0
X-Kernel: Linux 2.4.20 i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hi,

Can anyone explain the reason behind zap_page_ranges() not exported by the=
=20
kernel for use by modules, eventhough remap_page_ranges() is..

TIA,
	~john

--u3/rZRmxL6MmkK24
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE++vuOoUm9LrSG9ykRAs3vAJ96Z11nT+uN9S6SXG7EebxYEd1FcgCg0cwz
VU1qzihyc1kEYg+OmxXTFso=
=Rf93
-----END PGP SIGNATURE-----

--u3/rZRmxL6MmkK24--
