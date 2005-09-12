Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751116AbVILUBT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751116AbVILUBT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 16:01:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932186AbVILUBT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 16:01:19 -0400
Received: from emulex.emulex.com ([138.239.112.1]:10452 "EHLO
	emulex.emulex.com") by vger.kernel.org with ESMTP id S1751063AbVILUBS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 16:01:18 -0400
From: James.Smart@Emulex.Com
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6603.0
Subject: RE: [PATCH 2.6.13 5/14] sas-class: sas_discover.c Discover process (end devices)
Date: Mon, 12 Sep 2005 15:53:11 -0400
Message-ID: <9BB4DECD4CFE6D43AA8EA8D768ED51C20F45A0@xbl3.ma.emulex.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 2.6.13 5/14] sas-class: sas_discover.c Discover process (end devices)
Thread-Index: AcW30GQPUimodTLPRsGSefv2iGDR4gAAtnaA
To: <patmans@us.ibm.com>
Cc: <James.Bottomley@SteelEye.com>, <dougg@torque.net>, <hch@infradead.org>,
       <ltuikov@yahoo.com>, <luben_tuikov@adaptec.com>,
       <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I meant did you test many (even a few) LUNs with non 00b 
> addressing mode?
> 
> sg (scsi generic) had fixed limits removed some time ago (in 2.6.x).

Yes. tested with level 01b. As mentioned, I wouldn't recommend it.

- james
