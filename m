Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265933AbUBCIbx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 03:31:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265937AbUBCIbw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 03:31:52 -0500
Received: from fmr05.intel.com ([134.134.136.6]:62913 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S265933AbUBCIbv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 03:31:51 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: [ACPI] system crashes after cat /proc/acpi/battery/BAT0/state
Date: Tue, 3 Feb 2004 16:31:36 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F8401CBB672@PDSMSX403.ccr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [ACPI] system crashes after cat /proc/acpi/battery/BAT0/state
Thread-Index: AcPo5PaYH0ML0lOUR0KaTOrMPcLo4wBSgbbg
From: "Yu, Luming" <luming.yu@intel.com>
To: "Peter Muessig-Trapp" <muessig-trapp@web.de>,
       <acpi-devel@lists.sourceforge.net>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 03 Feb 2004 08:31:36.0736 (UTC) FILETIME=[2341F200:01C3EA30]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> excuse me, but I forgot to tell, that I'm using the ACPI DSDT initrd 
> patch and a special DSDT-file for Compaq Evo N800v (while I have an
> Compaq Evo N800c)

My question is whether your fixs to DSDT is correct or necessary? 
We need to sort out real ACPI interpreter bug !

--Luming
