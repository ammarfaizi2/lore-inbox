Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262210AbSKTS5Y>; Wed, 20 Nov 2002 13:57:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262289AbSKTS5Y>; Wed, 20 Nov 2002 13:57:24 -0500
Received: from pop.gmx.de ([213.165.65.60]:22123 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S262210AbSKTS5X>;
	Wed, 20 Nov 2002 13:57:23 -0500
From: Felix Seeger <felix.seeger@gmx.de>
To: <linux-kernel@vger.kernel.org>
Subject: 2.5.48 QM_MODULES: Function not implemented
Date: Wed, 20 Nov 2002 20:04:20 +0100
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200211202004.20261.felix.seeger@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello

I compiled 2.5.48 and now all the files like modules.dep in /lib/modules are 
away.

I can't load a module, I get this:
modprobe: Can't open dependencies file /lib/modules/2.5.48/modules.dep ...

depmod: QM_MODULES: Function not implemented

I enabled all option in the module config.


thanks
Felix
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE929y0S0DOrvdnsewRAoHiAJ4kq6cuX/EwWkbnxp4pfTaMrhGVkACeNKI/
PNXxtsjjv3QWWMVJ4qv2umk=
=no98
-----END PGP SIGNATURE-----

