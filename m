Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266005AbUHMPrw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266005AbUHMPrw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 11:47:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266014AbUHMPrv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 11:47:51 -0400
Received: from gw-oleane.hubxpress.net ([81.80.52.129]:53984 "EHLO
	yoda.hubxpress.net") by vger.kernel.org with ESMTP id S266005AbUHMPrl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 11:47:41 -0400
From: "Sylvain COUTANT" <sylvain.coutant@illicom.com>
To: "'Matt Domsch'" <Matt_Domsch@dell.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: High CPU usage (up to server hang) under heavy I/O load
Date: Fri, 13 Aug 2004 17:46:43 +0200
Organization: ILLICOM
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
In-Reply-To: <20040813153655.GB26340@lists.us.dell.com>
Thread-Index: AcSBS2KZQcdvdStbTymTDNEU+MQNVQAAEbWA
Message-Id: <20040813154737.7DCC12FC2C@illicom.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Matt,

> Which server please?

PE 2600 manufactured in June with latest PC BIOS and SCSI (PERC4/DI)
BIOS/Firmware. We also tried downgrading to the previous release (as we have
another PE2600 which runs fine with them) but it didn't do.

Add-ons are :
- Adaptec SCSI controller
- Total 3 Intel Pro 1000 Ethernet cards


About the other PE2600, it has the same hardware configuration, but not
exactly the same usage : more memory allocated to processes and far less I/O
loads. Although I'm not always satisfied with its performances, we didn't
notice something special on it so far.


Regards,
Sylvain.

