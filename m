Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751455AbWHWJFj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751455AbWHWJFj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 05:05:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751461AbWHWJFj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 05:05:39 -0400
Received: from sdcsmtp.europe.hp.net ([15.203.169.189]:35506 "EHLO
	sdcrelbas03.sdc.hp.com") by vger.kernel.org with ESMTP
	id S1751455AbWHWJFi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 05:05:38 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [PATCH] Update Documentation/devices.txt
Date: Wed, 23 Aug 2006 11:05:31 +0200
Message-ID: <93C4769E3BED6B42B7203BD6F065654C0424F3A1@dmoexc01.emea.cpqcorp.net>
In-Reply-To: <87sljo2fan.fsf@slug.be.48ers.dk>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] Update Documentation/devices.txt
Thread-Index: AcbGdNBAiwdwZ6BdQou7rlgBOq1PWAAHhsTg
From: "Mathiasen, Torben" <Torben.Mathiasen@hp.com>
To: "Peter Korsgaard" <jacmet@sunsite.dk>,
       "Jan Engelhardt" <jengelh@linux01.gwdg.de>
Cc: <linux-kernel@vger.kernel.org>, <device@lanana.org>
X-OriginalArrivalTime: 23 Aug 2006 09:05:32.0491 (UTC) FILETIME=[49A881B0:01C6C693]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> >>>>> "Jan" == Jan Engelhardt <jengelh@linux01.gwdg.de> writes:
> 
> Hi,
> 
>  >> 180 block	USB block devices
>  >> -		  0 = /dev/uba		First USB block device
>  >> -		  8 = /dev/ubb		Second USB block device
>  >> -		 16 = /dev/ubc		Third USB block device
>  >> -		    ...
>  >> +		0 = /dev/uba		First USB block device
>  >> +		8 = /dev/ubb		Second USB block device
>  >> +		16 = /dev/ubc		Third USB block device
>  >> + 		    ...
> 
>  Jan> What's the reason for this indent change?
> 
> I don't know - Torben?

A wrong indent it seems. If someone else is working on getting this fixed let me know. Otherwise I'll update the kernel version of devices.txt and fix the whitespaces at the same time.

Torben 
