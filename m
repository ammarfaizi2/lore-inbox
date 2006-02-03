Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932226AbWBCJxh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932226AbWBCJxh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 04:53:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932224AbWBCJxh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 04:53:37 -0500
Received: from [203.16.233.9] ([203.16.233.9]:60115 "EHLO borg.st.net.au")
	by vger.kernel.org with ESMTP id S932197AbWBCJxg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 04:53:36 -0500
Message-ID: <43E327C5.503@torque.net>
Date: Fri, 03 Feb 2006 19:52:05 +1000
From: Douglas Gilbert <dougg@torque.net>
Reply-To: dougg@torque.net
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-scsi@vger.kernel.org
CC: linux-kernel@vger.kernel.org
Subject: [Announce] sg3_utils-1.19 available
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

This version mainly updates various utilities to the
latest t10.org drafts and corrects some errors.
The interface to the linux SCSI pass through interface
has been made more generic. This has permitted ports of
most of the utilities to FreeBSD and Tru64.
See the CHANGELOG for more information.

A tarball, rpm and deb can be found at (see table 2):
http://www.torque.net/sg
For an overview of sg3_utils see this page:
http://www.torque.net/sg/u_index.html
The sg_dd utility has its own page at:
http://www.torque.net/sg/sg_dd.html
The SG_IO ioctl is discussed at:
http://www.torque.net/sg/sg_io.html
A changelog can be found at:
http://www.torque.net/sg/p/sg3_utils.CHANGELOG

A release announcement has been sent to freshmeat.net .

Doug Gilbert
