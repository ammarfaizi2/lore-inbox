Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932539AbVINA61@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932539AbVINA61 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 20:58:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932523AbVINA61
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 20:58:27 -0400
Received: from pat.qlogic.com ([198.70.193.2]:59488 "EHLO avexch01.qlogic.com")
	by vger.kernel.org with ESMTP id S932252AbVINA60 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 20:58:26 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6556.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [PATCH 2.6.13 5/14] sas-class: sas_discover.c Discover process (end devices)
Date: Tue, 13 Sep 2005 17:58:22 -0700
Message-ID: <3679966B84813344B908D418BA3F6A4A0461EE67@AVEXCH01.qlogic.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 2.6.13 5/14] sas-class: sas_discover.c Discover process (end devices)
Thread-Index: AcW4soaXrYnb9MHeS8yCg9HbpCVOIAAB7/3g
From: "Ravi Anand" <ravi.anand@qlogic.com>
To: "Patrick Mansfield" <patmans@us.ibm.com>,
       "Luben Tuikov" <luben_tuikov@adaptec.com>
Cc: "Matthew Wilcox" <matthew@wil.cx>,
       "James Bottomley" <James.Bottomley@SteelEye.com>,
       "Douglas Gilbert" <dougg@torque.net>,
       "Christoph Hellwig" <hch@infradead.org>,
       "Luben Tuikov" <ltuikov@yahoo.com>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "SCSI Mailing List" <linux-scsi@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 13, 2005 Patrick Mansfield wrote:
>>I think the only HBA's today that can handle an 8 byte lun are lpfc and
>>iscsi (plus new SAS ones).

In addition to that QLogic HBA's can handle an 8 byte lun as well.

Ravi
