Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751113AbWGKPzi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751113AbWGKPzi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 11:55:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751097AbWGKPzi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 11:55:38 -0400
Received: from mga01.intel.com ([192.55.52.88]:37726 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1750758AbWGKPzh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 11:55:37 -0400
X-IronPort-AV: i="4.06,229,1149490800"; 
   d="scan'208"; a="96311191:sNHT13194712797"
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5
Subject: RE: oops in current -git
Date: Tue, 11 Jul 2006 11:55:10 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB6F3116F@hdsmsx411.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: oops in current -git
Thread-Index: AcakaYRSQLxW3pGGTXSl/stA3+M4+QAmMTBw
From: "Brown, Len" <len.brown@intel.com>
To: "Jeff Garzik" <jeff@garzik.org>, "Netdev List" <netdev@vger.kernel.org>
Cc: "Linux Kernel" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 11 Jul 2006 15:55:13.0583 (UTC) FILETIME=[655E3BF0:01C6A502]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

try latest -mm, latest ACPI patch, or
try CONFIG_ACPI_BATTERY=n

-Len
