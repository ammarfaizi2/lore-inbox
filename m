Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261297AbUJ3SOL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261297AbUJ3SOL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 14:14:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261275AbUJ3SJx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 14:09:53 -0400
Received: from hostmaster.org ([212.186.110.32]:21893 "EHLO hostmaster.org")
	by vger.kernel.org with ESMTP id S261248AbUJ3SIF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 14:08:05 -0400
Subject: Re: status of DRM_MGA on x86_64
From: Thomas Zehetbauer <thomasz@hostmaster.org>
To: Dave Airlie <airlied@gmail.com>
Cc: Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
In-Reply-To: <21d7e997041030041748b60ce7@mail.gmail.com>
References: <1099052450.11282.72.camel@hostmaster.org.suse.lists.linux.kernel>
	 <1099061384.11918.4.camel@hostmaster.org.suse.lists.linux.kernel>
	 <41829E39.1000909@us.ibm.com.suse.lists.linux.kernel>
	 <1099097616.11918.26.camel@hostmaster.org.suse.lists.linux.kernel>
	 <p734qkd0y0n.fsf@verdi.suse.de> <21d7e99704103004155d2826fb@mail.gmail.com>
	 <21d7e997041030041748b60ce7@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-RYtkGgU6c7Si0yQ1MdUi"
Date: Sat, 30 Oct 2004 20:08:02 +0200
Message-Id: <1099159682.10313.23.camel@hostmaster.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-RYtkGgU6c7Si0yQ1MdUi
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Could you or someone else please explain the problem?

=46rom rom what I have read it seems that userland acesses some bitness
dependent kernel structures. Fixing this would mean to use architecture
independent structures in both kernel- and userland and break existing
applications.

As a user I would be satisfied if DRI is available for 64-bit
applications on x86_64 and 32-bit applications do not cause the kernel
to crash.

Tom

PS: I have Fedora running on a dual Opteron system with a Matrox
Millenium G550, tell me if you want to test something.

--=20
  T h o m a s   Z e h e t b a u e r   ( TZ251 )
  PGP encrypted mail preferred - KeyID 96FFCB89
      finger thomasz@hostmaster.org for key

Attempting to apply the OSI layers model to a real network is just like
attempting to represent seven dimensions in four dimensional reality.




--=-RYtkGgU6c7Si0yQ1MdUi
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iQEVAwUAQYPYgmD1OYqW/8uJAQIz5Af/cNOY1mkMCYdblHkSvPGeJG/wLemuzBih
8vjXFxv6NP0KFH3kQKyu9liUiBzYMqRClsppu1T1e8vkP83HcIvUstfkO8F66XyG
IVXGAeAdXhRgu7h9Y+VZi9qBmSxr9gzOWkrj5gg6afPk2DYPeAleS3KAvPzzHqsG
XfAz7whtnZf39M8XSPTQ/F342BVQV8vwac3SJaJlBW1j3p2OG9ziUxGCNmy5ZLYm
DAQR8Ochq23VP3vnLA0wmp2hflX6jB6537XiTx4vAJyFe2NB17PzIo04wfLinfXA
Ecxxe7GdjwFt01/3Cz1IH6hDsRxHlWJ1l3Zh5VWYjGsC1s0tvVVGtg==
=EPyk
-----END PGP SIGNATURE-----

--=-RYtkGgU6c7Si0yQ1MdUi--

