Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932497AbVKQSuj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932497AbVKQSuj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 13:50:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932502AbVKQSuj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 13:50:39 -0500
Received: from petasus.ims.intel.com ([62.118.80.130]:4568 "EHLO
	petasus.ims.intel.com") by vger.kernel.org with ESMTP
	id S932497AbVKQSui convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 13:50:38 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [linux-pm] [RFC] userland swsusp
Date: Thu, 17 Nov 2005 21:50:21 +0300
Message-ID: <6694B22B6436BC43B429958787E45498D551A7@mssmsx402nb>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [linux-pm] [RFC] userland swsusp
Thread-Index: AcXrnWskiiRthwPHQZebvj8efSO84wACeBgQ
From: "Starikovskiy, Alexey Y" <alexey.y.starikovskiy@intel.com>
To: "Olivier Galibert" <galibert@pobox.com>,
       "kernel list" <linux-kernel@vger.kernel.org>,
       "Linux-pm mailing list" <linux-pm@lists.osdl.org>
X-OriginalArrivalTime: 17 Nov 2005 18:50:21.0729 (UTC) FILETIME=[C3391110:01C5EBA7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 

>-----Original Message-----
>Is the acpi problem with PWRF used over PWRC and PWRF not sending
>events (hence no wakeup) solved?
It should be, look at #1920 in bugzilla.kernel.org
