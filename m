Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262748AbTCPUdN>; Sun, 16 Mar 2003 15:33:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262751AbTCPUdN>; Sun, 16 Mar 2003 15:33:13 -0500
Received: from 210-54-226-44.dialup.xtra.co.nz ([210.54.226.44]:260 "EHLO
	valhalla.neverborn.ORG") by vger.kernel.org with ESMTP
	id <S262748AbTCPUdM>; Sun, 16 Mar 2003 15:33:12 -0500
Date: Mon, 17 Mar 2003 08:43:46 +1200
From: "leon j. breedt" <ljb@neverborn.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Broadcom BCM5702 Major Problems
Message-ID: <20030316204346.GA6593@valhalla.neverborn.ORG>
Mime-Version: 1.0
Content-Type: application/pgp; x-action=sign; format=text
Content-Disposition: inline; filename="msg.pgp"
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

hi,

i am using an ASUS P4PE (intel 845PE chipset) that
has an onboard Broadcom BCM5702 adapter.

i also have ACPI, IO-APIC enabled, my driver statically
compiled into the kernel, and have not experienced any
problems such as you are describing since having
gotten this hardware.

i'm using 2.4.21-pre5-gss (gss=gentoo gs-sources patches),
and:

[*] Local APIC support on uniprocessors
[*] IO-APIC support on uniprocessors
[*] ACPI Support
<*> Broadcom Tigon3 support

so i'm not sure if the problem lies with the broadcom
driver...but i am cluelessly guessing here.

leon.

- -- 
in the beginning, was the code.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+dOICRWcl5mzp4f4RAmm8AJ9wLXHQ3ja3fQvaZQg1KzTbIKEAnQCfY/nQ
oeTNG7hyOoKlYNW+zW880wc=
=of7E
-----END PGP SIGNATURE-----
