Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261223AbVEFN25@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261223AbVEFN25 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 May 2005 09:28:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261222AbVEFN25
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 May 2005 09:28:57 -0400
Received: from zorg.st.net.au ([203.16.233.9]:49816 "EHLO borg.st.net.au")
	by vger.kernel.org with ESMTP id S261208AbVEFN2x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 May 2005 09:28:53 -0400
Message-ID: <427B704A.10202@torque.net>
Date: Fri, 06 May 2005 23:25:30 +1000
From: Douglas Gilbert <dougg@torque.net>
Reply-To: dougg@torque.net
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-scsi@vger.kernel.org
CC: linux-kernel@vger.kernel.org
Subject: [Announce] sg3_utils-1.14 available
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sg3_utils is a package of command line utilities for sending
SCSI commands to devices. This package targets the lk 2.6 and
lk 2.4 series. In the lk 2.6 series these utilities (except
sgp_dd) can be used with any devices that support the SG_IO
ioctl.

This version adds sg_rmsn to read media serial number(s).
The tarball contains a spec file for building rpms. That
spec file builds two binary rpms: sg3_utils and libsgutils.
In the future my plan is to make other utilities such as
sdparm depend on libsgutils. See CHANGELOG for other changes.

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
