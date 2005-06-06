Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261279AbVFFK2C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261279AbVFFK2C (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 06:28:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261275AbVFFK2C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 06:28:02 -0400
Received: from zorg.st.net.au ([203.16.233.9]:17571 "EHLO borg.st.net.au")
	by vger.kernel.org with ESMTP id S261274AbVFFK16 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 06:27:58 -0400
Message-ID: <42A42542.2030207@torque.net>
Date: Mon, 06 Jun 2005 20:28:18 +1000
From: Douglas Gilbert <dougg@torque.net>
Reply-To: dougg@torque.net
User-Agent: Mozilla Thunderbird 1.0.2-1.3.3 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-scsi@vger.kernel.org
CC: linux-kernel@vger.kernel.org
Subject: [Announce] sg3_utils-1.15 available
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sg3_utils is a package of command line utilities for sending
SCSI commands to devices. This package targets the lk 2.6 and
lk 2.4 series. In the lk 2.6 series these utilities (except
sgp_dd) can be used with any devices that support the SG_IO
ioctl.

This version includes minor enhancements, bug fixes and
man page improvements. See CHANGELOG for more information.

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
