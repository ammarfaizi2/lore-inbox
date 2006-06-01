Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965303AbWFAVEe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965303AbWFAVEe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 17:04:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965304AbWFAVEe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 17:04:34 -0400
Received: from fmr17.intel.com ([134.134.136.16]:35748 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S965303AbWFAVEd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 17:04:33 -0400
Content-class: urn:content-classes:message
From: Inaky Perez-Gonzalez <inaky@linux.intel.com>
To: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: ANNOUNCE: Linux UWB and Wireless USB project
Date: Thu, 1 Jun 2006 14:04:19 -0700
User-Agent: KMail/1.9.1
Cc: inaky.perez-gonzalez@intel.com
Organization: Intel Corporation
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606011404.20251.inaky@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Intel is pleased to announce the launch of a project to
implement Linux kernel support for upcoming hardware that
complies with the WiMedia Ultra Wide Band (UWB) and Wireless
USB standards.

UWB is a high-bandwidth, low-power, point-to-point radio
technology using a wide spectrum (3.1-10.6HGz).  It is
optimized for in-room use (480Mbps at 2 meters, 110Mbps at 10m).
It serves as the transport layer for other protocols, such as
Wireless USB (WUSB), IP (WiNET) and upcoming Bluetooth and 1394.
UWB is uniquely qualified to meet the needs of high-speed WPAN
applications.

The project is currently hosted at http://linuxuwb.org, where you
will find links to the current code, documentation, mailing list
and (upcoming) bugzilla.

All code is work in progress at this time, although the limited
functionality currently implemented is fairly stable; it consists
of a basic UWB stack with drivers for radio control, WiNET and a
forthcoming partially implemented Wireless USB host controller.
Please see the documentation for further information.

You are welcome to contribute!

-- Inaky
