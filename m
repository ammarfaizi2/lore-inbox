Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267326AbSLKVqW>; Wed, 11 Dec 2002 16:46:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267321AbSLKVqW>; Wed, 11 Dec 2002 16:46:22 -0500
Received: from mailout08.sul.t-online.com ([194.25.134.20]:42910 "EHLO
	mailout08.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S267326AbSLKVqV> convert rfc822-to-8bit; Wed, 11 Dec 2002 16:46:21 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Andreas Schaufler <andreas.schaufler@gmx.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: NFS mounted rootfs possible via PCMCIA NIC ?
Date: Wed, 11 Dec 2002 22:53:56 +0100
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200212112253.57325.andreas.schaufler@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello list,

I am trying to configure a notebook with a PCMCIA NIC to boot over network. 
(kernel 2.4.20)
In order to accomplish this I passed over the neccessary configuration 
paramters through the boot loader (ip, root, nfsroot)

The problem is: When the kernel is booting it is trying to configure the 
Network interface, before it has been activated.

Thus my question is: Is it possible somehow to change the order by some 
configuration parameter ?!?

Thanks for answers in advance

- -Andreas


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD4DBQE997P0hFLSFNIrGmsRAjMpAJitzpgKyTJDg6ubFy17u9GA+EZEAJ9kgBKv
k7Euyw1aT6/6ORWhzPjZwg==
=AmIZ
-----END PGP SIGNATURE-----

