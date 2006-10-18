Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161111AbWJRPAY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161111AbWJRPAY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 11:00:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161112AbWJRPAY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 11:00:24 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:45445 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1161111AbWJRPAX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 11:00:23 -0400
Message-ID: <453641DD.1040602@torque.net>
Date: Wed, 18 Oct 2006 11:01:49 -0400
From: Douglas Gilbert <dougg@torque.net>
Reply-To: dougg@torque.net
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: linux-scsi@vger.kernel.org
CC: linux-kernel@vger.kernel.org, emschwar@debian.org, robbat2@gentoo.org
Subject: [Announce] sg3_utils-1.22 available
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sg3_utils is a package of command line utilities for sending
SCSI (and some ATA) commands to devices. This package targets
the linux kernel (lk) 2.6 and lk 2.4 series. In the lk 2.6
series these utilities (except sgp_dd) can be used with any
devices that support the SG_IO ioctl.

This version adds the sg_sat_identify utility. This sends
an ATA IDENTIFY (PACKET) DEVICE command through a SAT layer
and can format its response suitable for hdparm ('--Istdin')
to decode. See the CHANGELOG for more information.

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
