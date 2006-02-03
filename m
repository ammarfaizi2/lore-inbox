Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751417AbWBCS2i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751417AbWBCS2i (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 13:28:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751401AbWBCS2h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 13:28:37 -0500
Received: from fmr22.intel.com ([143.183.121.14]:12958 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S1751350AbWBCS2f convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 13:28:35 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [PATCH] amd76x_pm: C3 powersaving for AMD K7
Date: Fri, 3 Feb 2006 13:28:13 -0500
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B3005EFF0A4@hdsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] amd76x_pm: C3 powersaving for AMD K7
Thread-Index: AcYo2t7zRMpS3n87QYWKDXSBE9fNZgAFFoGg
From: "Brown, Len" <len.brown@intel.com>
To: "Juhani Rautiainen" <juhani.rautiainen@gmail.com>
Cc: "Joerg Sommrey" <jo@sommrey.de>, "Andrew Morton" <akpm@osdl.org>,
       <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
       <tony@atomide.com>, <erik@slagter.name>, <alan@lxorguk.ukuu.org.uk>
X-OriginalArrivalTime: 03 Feb 2006 18:28:14.0760 (UTC) FILETIME=[98822A80:01C628EF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>If I understand errata correctly then enabling C2/C3 should be safe in
>SMP environment put not in single processor enviroment.

No, I would not assume SMP works when UP does not just because
SMP was not mentioned.  Things are generally easier to get right
in UP and harder to get right in SMP.

-Len
 

>
>Link:
>http://www.amd.com/us-en/assets/content_type/white_papers_and_tech_docs/24472.pdf
>
