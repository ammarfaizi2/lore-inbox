Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932454AbWBGGwj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932454AbWBGGwj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 01:52:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932455AbWBGGwj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 01:52:39 -0500
Received: from fmr18.intel.com ([134.134.136.17]:44434 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S932454AbWBGGwi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 01:52:38 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: EC interrupt mode by default breaks power button and lid button
Date: Tue, 7 Feb 2006 14:52:32 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F840ADDC619@pdsmsx403>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: EC interrupt mode by default breaks power button and lid button
thread-index: AcYrIp6bSejWeyxrQ7uW0I783H24rgAj+8CA
From: "Yu, Luming" <luming.yu@intel.com>
To: "Gerhard Schrenk" <deb.gschrenk@gmx.de>
Cc: "Brown, Len" <len.brown@intel.com>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 07 Feb 2006 06:52:34.0208 (UTC) FILETIME=[12DA6200:01C62BB3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Please don't revert that patch, and test kernel parameter ec_intr=0
>
>Yes, boot option ec_initr=0 helps power/lid buttons. (Tested with
>yesterdays newest kernel from linus' tree.)

Any difference with ec_initr=1 with this kernel ?
If pressing power button, can you see acpi interrupt increases?
