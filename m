Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286277AbRL0N6R>; Thu, 27 Dec 2001 08:58:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286300AbRL0N5d>; Thu, 27 Dec 2001 08:57:33 -0500
Received: from matav-4.matav.hu ([145.236.252.35]:59441 "EHLO
	Forman.fw.matav.hu") by vger.kernel.org with ESMTP
	id <S286294AbRL0N47>; Thu, 27 Dec 2001 08:56:59 -0500
Date: Thu, 27 Dec 2001 14:50:49 +0100 (CET)
From: Narancs v1 <narancs@narancs.tii.matav.hu>
X-X-Sender: narancs@helka
To: buytenh@gnu.org
Cc: acsgabi@acsgabi.tii.matav.hu, <linux-kernel@vger.kernel.org>,
        <manty@debian.org>
Subject: brctl 0.9.3 error on ultrasparc/linux 2.4.17
Message-ID: <Pine.LNX.4.43.0112271431280.30564-100000@helka>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Lennert!

We have a big trouble here, we have a so called "firewall" which has 5 eth
if.s and it is a sun ultra 5 ws. 2 ports should be used as an ethernet
bridge for filtering IPX between 2 ethernet segments.

I have read all the docs which came with the bridge-utils package.

On intel we use the same kernel, similar kernel config and it is working
fine.

on sparc we get this error message:

# brctl addbr br0
br_add_bridge: operation not supported

bridge module is loaded

distribution is debian woody/sparc

Thank you for your great help!

- -------------------------
Narancs v1
IT Security Administrator

"Security of information is an illusion.
What is in one's mind gets into the collective consciousness (akasha),
so that can be read with meditation ;-) You don't have to hack.
Just 'remember'! You're the one." (Me)

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjwrJz0ACgkQGp+ylEhMCIWltwCeO1Ym+ql04TjPGX6I+4ragtVQ
Jz4An3tBaPaE+lrqCI6LDOTHJQQjfkYr
=Ol5F
-----END PGP SIGNATURE-----

