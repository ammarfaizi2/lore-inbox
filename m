Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751220AbWBMIFf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751220AbWBMIFf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 03:05:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751222AbWBMIFf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 03:05:35 -0500
Received: from fmr18.intel.com ([134.134.136.17]:28820 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751196AbWBMIFd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 03:05:33 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: Linux 2.6.16-rc3
Date: Mon, 13 Feb 2006 03:02:46 -0500
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B30060BD1D9@hdsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Linux 2.6.16-rc3
Thread-Index: AcYwbXiRFU740E2oSpy5EoK2eFFRjAABMNOg
From: "Brown, Len" <len.brown@intel.com>
To: "David S. Miller" <davem@davemloft.net>
Cc: <akpm@osdl.org>, <torvalds@osdl.org>, <linux-kernel@vger.kernel.org>,
       <axboe@suse.de>, <James.Bottomley@steeleye.com>, <greg@kroah.com>,
       <linux-acpi@vger.kernel.org>, <linux-usb-devel@lists.sourceforge.net>,
       "Yu, Luming" <luming.yu@intel.com>, <lk@bencastricum.nl>,
       <sanjoy@mrao.cam.ac.uk>, <helgehaf@aitel.hist.no>, <fluido@fluido.as>,
       <gbruchhaeuser@gmx.de>, <Nicolas.Mailhot@LaPoste.net>, <perex@suse.cz>,
       <tiwai@suse.de>, <patrizio.bassi@gmail.com>, <bni.swe@gmail.com>,
       <arvidjaar@mail.ru>, <p_christ@hol.gr>, <ghrt@dial.kappa.ro>,
       <jinhong.hu@gmail.com>, <andrew.vasquez@qlogic.com>,
       <linux-scsi@vger.kernel.org>, <bcrl@kvack.org>
X-OriginalArrivalTime: 13 Feb 2006 08:02:50.0559 (UTC) FILETIME=[E278FCF0:01C63073]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> >- In http://bugzilla.kernel.org/show_bug.cgi?id=5989, Sanjoy 
>> >Mahajan has  another regression, but he's off collecting more info.
>> 
>> We're talking here about a system from 1999 where Windows 98
>> refuses to run in ACPI mode and instead runs in APM mode.
>
>If it worked before a change which was installed, it's a regression
>regardless of whether another OS tries to use ACPI on that system or
>not.  I don't understand how one can use that fact to label this as
>not a regression from Linux's perspective.

I don't think anybody claimed this isn't a regression for the 600X.
Sanjoy has done a wonderful job documenting that.

My point is that it that on the grand scale of bugs serious enough
to have an effect on the course of 2.6.16, this one doesn't qualify
unless the same issue is seen on other systems.

-Len
