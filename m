Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267961AbUIAHfo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267961AbUIAHfo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 03:35:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268870AbUIAHfo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 03:35:44 -0400
Received: from fmr05.intel.com ([134.134.136.6]:33447 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S267961AbUIAHfL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 03:35:11 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: problem with ACPI and suspend
Date: Wed, 1 Sep 2004 15:35:11 +0800
Message-ID: <B44D37711ED29844BEA67908EAF36F03B0DA18@pdsmsx401.ccr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: problem with ACPI and suspend
Thread-Index: AcSPt6uvK+YPV5woQIGGYImlWxNNkQAPmMDA
From: "Li, Shaohua" <shaohua.li@intel.com>
To: "Peder Stray" <peder.stray@gmail.com>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Brown, Len" <len.brown@intel.com>
X-OriginalArrivalTime: 01 Sep 2004 07:35:03.0812 (UTC) FILETIME=[32141440:01C48FF6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Did you load ACPI button driver?   

Shaohua

>-----Original Message-----
>From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-
>owner@vger.kernel.org] On Behalf Of Peder Stray
>Sent: Wednesday, September 01, 2004 3:00 AM
>To: linux-kernel@vger.kernel.org
>Subject: problem with ACPI and suspend
>
>ACPI works quite ok on my laptop, currently running 2.6.8, but when i
>resume from suspend the second time after a boot i get the following
>message:
>
>    ACPI-0286: *** Error: No installed handler for fixed event
[00000002]
>
>and the acpi subsystems seem to stop sending events, as no scripts
>gets called after this. Anyone had similar problems? I really would
>like to have working suspend/resume more than once after each reboot
>;)
>
>--
>  Peder Stray
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
