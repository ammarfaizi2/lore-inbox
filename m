Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262707AbUCEVBm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 16:01:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262709AbUCEVBm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 16:01:42 -0500
Received: from ausadmmsps308.aus.amer.dell.com ([143.166.224.103]:51473 "HELO
	AUSADMMSPS308.aus.amer.dell.com") by vger.kernel.org with SMTP
	id S262707AbUCEVBj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 16:01:39 -0500
X-Server-Uuid: 5333cdb1-2635-49cb-88e3-e5f9077ccab5
x-mimeole: Produced By Microsoft Exchange V6.0.6527.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: ACPI stack overflow
Date: Fri, 5 Mar 2004 15:01:34 -0600
Message-ID: <CE41BFEF2481C246A8DE0D2B4DBACF4F128AA1@ausx2kmpc106.aus.amer.dell.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: ACPI stack overflow
Thread-Index: AcQC9Qp3NjK7rdfrQ/uTvTuC2jul5A==
From: Stuart_Hayes@Dell.com
To: linux-kernel@vger.kernel.org
cc: andrew.grover@intel.com
X-OriginalArrivalTime: 05 Mar 2004 21:01:35.0293 (UTC)
 FILETIME=[0B4B16D0:01C402F5]
X-WSS-ID: 6C5635381983673-01-01
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello...

I think I am getting a stack overflow when Linux is parsing the ACPI tables (initializing all the devices and running all the _STA methods).  I am using the x86_64 architecture.  I would like to try increasing the kernel stack size, but I'm not sure how to go about doing this.  Could someone tell me how to increase the kernel stack size?  (And, has anyone else seen a problem with stack overflows with ACPI?)

Thanks!
Stuart
stuart_hayes@dell.com


