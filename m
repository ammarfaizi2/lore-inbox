Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266047AbUALFO6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 00:14:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266048AbUALFO6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 00:14:58 -0500
Received: from fmr05.intel.com ([134.134.136.6]:33457 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S266047AbUALFO5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 00:14:57 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: ACPI: problem on ASUS PR-DLS533
Date: Mon, 12 Jan 2004 13:14:48 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F8401720CA8@PDSMSX403.ccr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: ACPI: problem on ASUS PR-DLS533
Thread-Index: AcPVGsFSl5lM+R3iTnWFTfSivyz6rgDru0Nw
From: "Yu, Luming" <luming.yu@intel.com>
To: "Stephan von Krawczynski" <skraw@ithnet.com>
Cc: <andreas@xss.co.at>, <andrew@walrond.org>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 12 Jan 2004 05:14:49.0396 (UTC) FILETIME=[00725740:01C3D8CB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> >I have some TRL-DLS here (P-III). They have dual AIC onboard which
are
>> not
>> >recognised under 2.4.24 but work flawlessly with ACPI in 2.4.23.
>> 
>> Are you sure?  You seems to want to say this is a regression.
>
>Yes. That is exactly what happened.
>
>2.4.23 works flawlessly
>2.4.24 does not recognise both onboard aic

Since you are so sure, could you file a tracker on bugzilla, and post
info
to demonstrate that fact. It's really interesting.
