Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263448AbUGAClp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263448AbUGAClp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 22:41:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263413AbUGAClc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 22:41:32 -0400
Received: from fmr05.intel.com ([134.134.136.6]:38844 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S263085AbUGAClX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 22:41:23 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
Subject: RE: thermal_zone, infos ?
Date: Thu, 1 Jul 2004 10:40:52 +0800
Message-ID: <6E0C289723A0564F9A8279E236E8565F07AF4BE3@pdsmsx402.pd.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: thermal_zone, infos ?
Thread-Index: AcRe2lpB/QYnh+a3SqqEUcoLFPIKdgAOgGJw
From: "Wang, Zhenyu Z" <zhenyu.z.wang@intel.com>
To: "George Marshall" <giorgega@tiscali.it>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 01 Jul 2004 02:40:54.0084 (UTC) FILETIME=[D468D040:01C45F14]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can take a look at ACPI spec, Chapter 12.
http://www.acpi.info

The name "THRM" is defined in your DSDT. 
If you hate that name, look into http://acpi.sourceforge.net/dsdt/index.php

-zhen

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of George Marshall
Sent: 2004年7月1日 3:34
To: linux-kernel@vger.kernel.org
Subject: thermal_zone, infos ?

Hi all, is there any doc about thermal_zone ?
Is the path to the "temperature" file always
a fixed path ?
eg: /proc/acpi/thermal_zone/THRM/temperature

I guess the "THRM" dir name may change, but
how ?  THM0 ?

Regards

PS: cc replies are welcome :)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

