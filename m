Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262746AbUKMAgh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262746AbUKMAgh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 19:36:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262731AbUKMAea
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 19:34:30 -0500
Received: from fmr12.intel.com ([134.134.136.15]:62100 "EHLO
	orsfmr001.jf.intel.com") by vger.kernel.org with ESMTP
	id S262746AbUKMAbm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 19:31:42 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: 2.6.10-rc1-mm5
Date: Fri, 12 Nov 2004 16:30:56 -0800
Message-ID: <44BDAFB888F59F408FAE3CC35AB47041F5A35C@orsmsx409>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.10-rc1-mm5
Thread-Index: AcTJFmgzQtcpdYQGSwKFgufIL2Wb2gAATnig
From: "Keshavamurthy, Anil S" <anil.s.keshavamurthy@intel.com>
To: "Greg KH" <greg@kroah.com>, "Andrew Morton" <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, "Brown, Len" <len.brown@intel.com>
X-OriginalArrivalTime: 13 Nov 2004 00:30:58.0596 (UTC) FILETIME=[0BB3FE40:01C4C918]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,
	This is fixed in the latest Len's acpi tree, when you pull from
his tree next time this should have been fixed.

Thanks,
Anil 
>-----Original Message-----
>From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-
>owner@vger.kernel.org] On Behalf Of Greg KH
>Sent: Friday, November 12, 2004 4:12 PM
>To: Andrew Morton
>Cc: linux-kernel@vger.kernel.org
>Subject: Re: 2.6.10-rc1-mm5
>
>On Thu, Nov 11, 2004 at 01:23:33AM -0800, Andrew Morton wrote:
>>
>> - Let me be the first to report this:
>>
>> 	*** Warning: "hotplug_path" [drivers/acpi/container.ko]
undefined!
>
>The acpi developers know about this and they said they would fix it in
>their code tree before pushing to Linus.
>
>thanks,
>
>greg k-h
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
