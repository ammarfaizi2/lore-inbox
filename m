Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264401AbUANXOE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 18:14:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265165AbUANXEh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 18:04:37 -0500
Received: from enigma.qlogic.com ([198.70.193.17]:46582 "EHLO enigma.qlc.com")
	by vger.kernel.org with ESMTP id S264522AbUANWzk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 17:55:40 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: [ANNOUNCE] QLogic qla2xxx driver update available (v8.00.00b9).
Date: Wed, 14 Jan 2004 14:55:54 -0800
Message-ID: <B179AE41C1147041AA1121F44614F0B060EDDD@AVEXCH02.qlogic.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [ANNOUNCE] QLogic qla2xxx driver update available (v8.00.00b9).
Thread-Index: AcPa8ZAUqmSj2iSmQ8ezUa24UFU7xQ==
From: "Andrew Vasquez" <andrew.vasquez@qlogic.com>
To: "Linux-Kernel" <linux-kernel@vger.kernel.org>,
       "Linux-SCSI" <linux-scsi@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,

A new version of the 8.x series driver for Linux 2.6.x kernels has
been uploaded to SourceForge:

	http://sourceforge.net/projects/linux-qla2xxx/

Changes from previous release (8.00.00b8) include:

	o Merge several patches from Christoph Hellwig:
	  - IOCTL code optional and split from main code.
	  - Simplify wait routines used for MBX commands and IOCTLS.
	o Add full support for three new ISP chips - ISP2322, ISP6312,
	  and ISP6322.
	  - The increased size of the distribution tarball is a result
	    of the three new firmwares needed to support the chips.

Review the revision notes for further details of the changes in
8.00.00b9.

Regards,
Andrew Vasquez
QLogic Corporation
