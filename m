Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135221AbRDRRMO>; Wed, 18 Apr 2001 13:12:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135223AbRDRRMA>; Wed, 18 Apr 2001 13:12:00 -0400
Received: from gadget.lut.ac.uk ([158.125.96.50]:55562 "EHLO gadget.lut.ac.uk")
	by vger.kernel.org with ESMTP id <S133113AbRDRRKt>;
	Wed, 18 Apr 2001 13:10:49 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: "Grover, Andrew" <andrew.grover@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.3-ac7 
In-Reply-To: Message from "Grover, Andrew" <andrew.grover@intel.com> 
   of "Tue, 17 Apr 2001 10:41:37 PDT." <4148FEAAD879D311AC5700A0C969E8905DE848@orsmsx35.jf.intel.com> 
Date: Wed, 18 Apr 2001 18:10:45 +0100
From: Martin Hamilton <martin@net.lut.ac.uk>
Message-Id: <E14pvTZ-0005F5-00@gadget.lut.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Content-Type: text/plain; charset=us-ascii

"Grover, Andrew" writes:

| (BTW, read the ACPI 2.0 spec - it's a lot better)

I'm getting there...  perhaps tomorrow :-))

| ACPI is meant to abstract the OS from all the "magic numbers". It's very
| possible to do things in a platform-specific way, but if you want to handle
| all platforms, you'd end up with something ACPI-like.

This isn't me talking, but I think you know the objection from
hardcore Linux folk is essentially that Linux is the only platform for
which platform-specific stuff should go into the Linux kernel.  I
don't really mind so long as suspend-to-disk and resume work... ;-)

| We're working on this. The major issue now is device power management. 

I was wondering whether the swsusp work might form a useful basis for 
the eventual ACPI implementation of the to-disk hibernation stuff:

  http://falcon.sch.bme.hu/~seasons/linux/swsusp.html

Am hoping this will resolve my immediate problem with the Vaio :-)

Cheers,

Martin




-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: Exmh version 2.1.1 10/15/1999 + martin

iD8DBQE63cqVVw+hz3xBJfQRAkYzAJ9R2oNuhC2OtUONePouYWerPQAclgCeIWTR
os+2g40W0fJBVq5eFDrHLXM=
=fPzf
-----END PGP SIGNATURE-----

