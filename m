Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269193AbRGaGb4>; Tue, 31 Jul 2001 02:31:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269195AbRGaGbr>; Tue, 31 Jul 2001 02:31:47 -0400
Received: from titan.golden.net ([199.166.210.90]:43473 "EHLO titan.golden.net")
	by vger.kernel.org with ESMTP id <S269193AbRGaGbd>;
	Tue, 31 Jul 2001 02:31:33 -0400
From: "John L. Males" <software_iq@TheOffice.net>
Organization: Toronto, Ontario, Canada
To: linux-kernel@vger.kernel.org
Date: Tue, 31 Jul 2001 02:31:25 -0500
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Linux Kernel 2.4.8-pre2 Compile Attempts
Reply-to: software_iq@TheOffice.net
Message-ID: <3B66187D.17040.4C80F5@localhost>
X-mailer: Pegasus Mail for Win32 (v3.12c)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello,

Without giving the gory details, I am curious to know if there are
still problems compiling the 2.4.8-pre2 kernel (2.4.7 + 2.4.8-pre2
patch).  Specifically the "make modules" does not complete dues to
some errors, the kernel compiles, but will not start after it is
decompressed, if one uses the "-k -i" options of make for the modules
to skip those that are really not a big concern to me anyway, there
seems to be problems with "make modules_install" either not working
or some other strange thing.  Also what is installed in /lib/modules
tree is not just modules, but some extensive set of the kernel source
tree with object code mixed in for adventure of finding.

All I really wanted to do was give the 2.4.8pre2 kernel a try to see
if memory management was improved with the recent approaches.  I did
try a prior 2.4 kernel, not sure, but think it was 2.4.4 and it had
its share of compile problems via make.  Am I completely out to lunch
here, or should I just hang in.  I am doing ok with the 2.2.19 Linus
Kernel with the Openwall patch, but I really would like to observe
the work in memory management of the kernel to determine if may
observations on how memory is management in the bigger picture to
determine if I wish to offer my observations to the memory management
discussion.


Regards,

John L. Males
Software I.Q. Consulting
Toronto, Ontario
Canada
31 July 2001 02:31
mailto:software_iq@TheOffice.net
mailto:jlmales@softhome.net

-----BEGIN PGP SIGNATURE-----
Version: PGPfreeware 6.5.8 for non-commercial use <http://www.pgp.com>

iQA/AwUBO2ZeyfLzhJbmoDZ+EQLWMQCeJCO8ncZ8WW51ufl+CWt2oLhDsmoAnj4U
XmokefDd3smnPvFBdoO9wdDd
=XX0U
-----END PGP SIGNATURE-----

