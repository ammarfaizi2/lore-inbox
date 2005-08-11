Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751074AbVHKXhN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751074AbVHKXhN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 19:37:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751111AbVHKXhM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 19:37:12 -0400
Received: from zorg.st.net.au ([203.16.233.9]:36836 "EHLO borg.st.net.au")
	by vger.kernel.org with ESMTP id S1751073AbVHKXhL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 19:37:11 -0400
Message-ID: <42FBE124.30005@torque.net>
Date: Fri, 12 Aug 2005 09:37:08 +1000
From: Douglas Gilbert <dougg@torque.net>
Reply-To: dougg@torque.net
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-scsi@vger.kernel.org
CC: linux-kernel@vger.kernel.org
Subject: [Announce] sg3_utils-1.16 available
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

sg3_utils is a package of command line utilities for sending
SCSI commands to devices. This package targets the lk 2.6 and
lk 2.4 series. In the lk 2.6 series these utilities (except
sgp_dd) can be used with any devices that support the SG_IO
ioctl.

This version adds sg_ident to report and set device identifiers.
It extends various device scanning utilities beyond 256 device
and includes bug fixes and man page improvements. See CHANGELOG
for more information.

A tarball, rpm and deb can be found on (see table 2):
http://www.torque.net/sg
For an overview of sg3_utils see this page:
http://www.torque.net/sg/u_index.html
The sg_dd utility has its own page at:
http://www.torque.net/sg/sg_dd.html
A changelog can be found at:
http://www.torque.net/sg/p/sg3_utils.CHANGELOG

A release announcement has been sent to freshmeat.net .

Doug Gilbert

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFC++Eknayo+9E+FQIRAgQSAKCL7EirWTNuvvF3uqdN4OgnQr2bdwCdE/gY
sq8wzUyPkd/vPr1Xc8+T+Es=
=NU4B
-----END PGP SIGNATURE-----
