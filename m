Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262692AbSLBMTa>; Mon, 2 Dec 2002 07:19:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262780AbSLBMTa>; Mon, 2 Dec 2002 07:19:30 -0500
Received: from c17928.thoms1.vic.optusnet.com.au ([210.49.249.29]:39809 "EHLO
	laptop.localdomain") by vger.kernel.org with ESMTP
	id <S262692AbSLBMT3> convert rfc822-to-8bit; Mon, 2 Dec 2002 07:19:29 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Con Kolivas <conman@kolivas.net>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: 2.4.20-ck1
Date: Mon, 2 Dec 2002 23:29:16 +1100
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200212022329.23006.conman@kolivas.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I've updated my patchset to resync with 2.4.20

Included:
O(1)
Preemptible
Low Latency
AA VM addons
ALSA
Supermount
XFS
ACPI

optional rmap

and an ugly low latency disk hack (can be turned off during config)

In a slight departure from the direction I started taking towards the end of 
the 2.4.19 patchset I am only including patches that are known to be safe and 
reasonably well tested.

A split out patchset is available.

Get it here:
http://kernel.kolivas.net

Cheers,
Con
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE961IfF6dfvkL3i1gRAg2wAJ9PrWHTdBO1HXfzbfA2KDy6luPgggCfW4Vt
48c8kJNGTmFOWqiTXEPVaIA=
=J9G4
-----END PGP SIGNATURE-----
