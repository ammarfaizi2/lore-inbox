Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932144AbWGGM1v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932144AbWGGM1v (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 08:27:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932143AbWGGM1u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 08:27:50 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:43751 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932122AbWGGM1u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 08:27:50 -0400
Message-ID: <44AE5342.90408@torque.net>
Date: Fri, 07 Jul 2006 08:27:46 -0400
From: Douglas Gilbert <dougg@torque.net>
Reply-To: dougg@torque.net
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-scsi@vger.kernel.org
CC: linux-kernel@vger.kernel.org, emschwar@debian.org, robbat2@gentoo.org
Subject: [Announce] sg3_utils-1.21 available
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sg3_utils is a package of command line utilities for sending
SCSI (and some ATA) commands to devices. This package targets
the linux kernel (lk) 2.6 and lk 2.4 series. In the lk 2.6
series these utilities (except sgp_dd) can be used with any
devices that support the SG_IO ioctl.
A subset of the utilities in this package will build on FreeBSD
and Tru64.

This version adds the sg_vpd and sg_rdac utilities. There are
examples of using the SAT ATA pass through SCSI command.
Exit status values have been expanded and made more consistent.
See the CHANGELOG for more information.

A tarball, rpm and deb can be found at (see table 2):
http://www.torque.net/sg
For an overview of sg3_utils see this page:
http://www.torque.net/sg/sg3_utils.html
The sg_dd utility has its own page at:
http://www.torque.net/sg/sg_dd.html
The SG_IO ioctl is discussed at:
http://www.torque.net/sg/sg_io.html
A changelog can be found at:
http://www.torque.net/sg/p/sg3_utils.CHANGELOG

A release announcement has been sent to freshmeat.net .

Doug Gilbert
