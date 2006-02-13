Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751181AbWBMHK0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751181AbWBMHK0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 02:10:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751109AbWBMHK0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 02:10:26 -0500
Received: from fmr20.intel.com ([134.134.136.19]:32665 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751106AbWBMHKY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 02:10:24 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: Linux 2.6.16-rc3
Date: Mon, 13 Feb 2006 02:07:50 -0500
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B30060BD1D1@hdsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Linux 2.6.16-rc3
Thread-Index: AcYwStHjOtfHPCjdTnC7JdV+LdTOHwAIMlfQ
From: "Brown, Len" <len.brown@intel.com>
To: "Andrew Morton" <akpm@osdl.org>, "Linus Torvalds" <torvalds@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, "Jens Axboe" <axboe@suse.de>,
       "James Bottomley" <James.Bottomley@steeleye.com>,
       "David S. Miller" <davem@davemloft.net>, "Greg KH" <greg@kroah.com>,
       <linux-acpi@vger.kernel.org>, <linux-usb-devel@lists.sourceforge.net>,
       "Yu, Luming" <luming.yu@intel.com>,
       "Ben Castricum" <lk@bencastricum.nl>, <sanjoy@mrao.cam.ac.uk>,
       "Helge Hafting" <helgehaf@aitel.hist.no>,
       "Carlo E. Prelz" <fluido@fluido.as>,
       <linux-usb-devel@lists.sourceforge.net>,
       =?iso-8859-1?Q?Gerrit_Bruchh=E4user?= <gbruchhaeuser@gmx.de>,
       <Nicolas.Mailhot@LaPoste.net>, "Jaroslav Kysela" <perex@suse.cz>,
       "Takashi Iwai" <tiwai@suse.de>,
       "Patrizio Bassi" <patrizio.bassi@gmail.com>,
       =?iso-8859-1?Q?Bj=F6rn_Nilsson?= <bni.swe@gmail.com>,
       "Andrey Borzenkov" <arvidjaar@mail.ru>,
       "P. Christeas" <p_christ@hol.gr>, "ghrt" <ghrt@dial.kappa.ro>,
       "jinhong hu" <jinhong.hu@gmail.com>,
       "Andrew Vasquez" <andrew.vasquez@qlogic.com>,
       <linux-scsi@vger.kernel.org>, "Benjamin LaHaise" <bcrl@kvack.org>
X-OriginalArrivalTime: 13 Feb 2006 07:07:53.0473 (UTC) FILETIME=[35419710:01C6306C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
>- In http://bugzilla.kernel.org/show_bug.cgi?id=5989, Sanjoy 
>Mahajan has  another regression, but he's off collecting more info.

We're talking here about a system from 1999 where Windows 98
refuses to run in ACPI mode and instead runs in APM mode.
So I don't consider a regression on this box as "serious" --
I consider that it works in ACPI mode at all as "miraculous":-)

However, I do think the issue merits investigation in the event
that it has an effect on systems newer than 6 years old.

thanks,
-Len

