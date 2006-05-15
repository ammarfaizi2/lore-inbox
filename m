Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965090AbWEOSJB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965090AbWEOSJB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 14:09:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965073AbWEOSJA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 14:09:00 -0400
Received: from mga02.intel.com ([134.134.136.20]:23461 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S965072AbWEOSI7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 14:08:59 -0400
X-IronPort-AV: i="4.05,130,1146466800"; 
   d="scan'208"; a="36528458:sNHT2738829716"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: acpi_power_off doesn't
Date: Mon, 15 May 2006 13:54:21 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB670FB98@hdsmsx411.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: acpi_power_off doesn't
Thread-Index: AcZ4SB7FeWROXTCSQlaVQMv0ug4mEgAADIcA
From: "Brown, Len" <len.brown@intel.com>
To: "Harald Dunkel" <harald.dunkel@t-online.de>,
       <linux-kernel@vger.kernel.org>
Cc: <linux-acpi@vger.kernel.org>
X-OriginalArrivalTime: 15 May 2006 17:54:22.0965 (UTC) FILETIME=[992F9A50:01C67848]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Sometimes when I run 'halt' my PC does not go off. Last
>words are
>
>	acpi_power_off called
>
>But the PC stays on.
>
>What is the story here? I've seen this problem come up
>several times, but without solution, as it seems. Any
>hint would be very helpfull.

Does this happen all the time, or just some of the time?
Has this always failed on box X, or did it used to
work in some release Y, and broke in some release Z?

Please supply X, Y, Z.

thanks,
-Len
