Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267505AbUI1C15@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267505AbUI1C15 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 22:27:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267487AbUI1C15
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 22:27:57 -0400
Received: from fmr12.intel.com ([134.134.136.15]:30388 "EHLO
	orsfmr001.jf.intel.com") by vger.kernel.org with ESMTP
	id S267508AbUI1C14 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 22:27:56 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: suspend/resume support for driver requires an external firmware
Date: Tue, 28 Sep 2004 10:27:48 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F8403BD579B@pdsmsx403>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: suspend/resume support for driver requires an external firmware
Thread-Index: AcSkZtAS81qw0YtiQfK3uBahmBP0BwAm6fjw
From: "Zhu, Yi" <yi.zhu@intel.com>
To: "Oliver Neukum" <oliver@neukum.org>
Cc: "Patrick Mochel" <mochel@digitalimplant.org>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 28 Sep 2004 02:27:49.0453 (UTC) FILETIME=[BF7F5FD0:01C4A502]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oliver Neukum wrote:
>> Do you suggest before user echo 4 > /proc/acpi/sleep, [s]he must do
>> something like cat /path/of/firmware > /proc/net/ipw2100/firmware?
> 
> Yes.

I prefer it could be transparent to users.

Thanks,
-yi
