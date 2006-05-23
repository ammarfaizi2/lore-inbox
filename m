Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932225AbWEWNmY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932225AbWEWNmY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 09:42:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932228AbWEWNmY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 09:42:24 -0400
Received: from mga02.intel.com ([134.134.136.20]:35219 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S932110AbWEWNmX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 09:42:23 -0400
X-IronPort-AV: i="4.05,161,1146466800"; 
   d="scan'208"; a="40120960:sNHT26783050"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH/RFC 2.6.17-rc4 1/1] ACPI: Atlas ACPI driver v2
Date: Tue, 23 May 2006 21:41:53 +0800
Message-ID: <554C5F4C5BA7384EB2B412FD46A3BAD11206E4@pdsmsx411.ccr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH/RFC 2.6.17-rc4 1/1] ACPI: Atlas ACPI driver v2
Thread-Index: AcZ66K+gXbTD0Ox3S+mdaq+ZQ4O43wDhaTdg
From: "Yu, Luming" <luming.yu@intel.com>
To: <jayakumar.acpi@gmail.com>, <linux-kernel@vger.kernel.org>,
       <linux-acpi@vger.kernel.org>
X-OriginalArrivalTime: 23 May 2006 13:41:55.0160 (UTC) FILETIME=[A7B1FD80:01C67E6E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



>( fyi, the brightness control part of that patch depends on Luming's
>hotkey patch which I guess isn't in mainline. That patch is here at
>http://bugzilla.kernel.org/show_bug.cgi?id=5749 )
>
>That combined patch then got a sign off from Luming:
>
>http://marc.theaimsgroup.com/?l=linux-acpi&m=114308645502914&w=2
>
>After that I didn't do anything further and I guess nothing further
>happened with that. Then I noticed Matthew Garrett's patch adding
>input support to the acpi button driver.

Ok, I will push them into mm tree.

--Luming
