Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270697AbTGNSm1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 14:42:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270709AbTGNSm0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 14:42:26 -0400
Received: from fmr06.intel.com ([134.134.136.7]:9935 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S270697AbTGNSla convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 14:41:30 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: Linux 2.6-pre1 Does not boot on ASUS L3800C: lock up in acpi while  "Executing all Devices _STA and_INIT methods" 
Date: Mon, 14 Jul 2003 11:56:17 -0700
Message-ID: <F760B14C9561B941B89469F59BA3A847E9702C@orsmsx401.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Linux 2.6-pre1 Does not boot on ASUS L3800C: lock up in acpi while  "Executing all Devices _STA and_INIT methods" 
Thread-Index: AcNKCul0mRir4BAbRMC6TM/wjm340AALp+0Q
From: "Grover, Andrew" <andrew.grover@intel.com>
To: <eric.valette@free.fr>, <linux-kernel@vger.kernel.org>
Cc: <acpi-devel@lists.sourceforge.net>
X-OriginalArrivalTime: 14 Jul 2003 18:56:17.0704 (UTC) FILETIME=[9B62CA80:01C34A39]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Eric Valette [mailto:eric.valette@free.fr] 
> I happily run 2.4.21-pre5 with ACPI enabled and everything works just 
> fine. I tried today 2.6-pre1 with exactly the same hardware 
> configuration as the 2.4 one and the laptop does not boot. It hangs 
> while dispaying : "Executing all Devices _STA and_INIT methods" 
> allthough it has already printed several '.'

That's weird. They should have the same version of the ACPI code...

-- Andy
