Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265600AbUBBEeF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Feb 2004 23:34:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265603AbUBBEeF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Feb 2004 23:34:05 -0500
Received: from fmr02.intel.com ([192.55.52.25]:5026 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id S265600AbUBBEeC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Feb 2004 23:34:02 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: ACPI -- Workaround for broken DSDT
Date: Sun, 1 Feb 2004 23:33:44 -0500
Message-ID: <BF1FE1855350A0479097B3A0D2A80EE0CC8A85@hdsmsx402.hd.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: ACPI -- Workaround for broken DSDT
Thread-Index: AcPpLz9bBsNAONgwQ9Oh8XE9VuDgpAAFZDpA
From: "Brown, Len" <len.brown@intel.com>
To: <trelane@digitasaru.net>
Cc: <bluefoxicy@linux.net>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 02 Feb 2004 04:33:46.0338 (UTC) FILETIME=[BF064420:01C3E945]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The vendor should supply a correct DSDT with their BIOS.
In the case of Dell, you might inquire here: http://linux.dell.com/

For non-vendor supplied solutions, you might also follow the DSDT link
here: http://acpi.sourceforge.net/  

Cheers,
-Len




> -----Original Message-----
> From: Joseph Pingenot [mailto:trelane@digitasaru.net] 
> Sent: Monday, February 02, 2004 1:05 AM
> To: Brown, Len
> Cc: bluefoxicy@linux.net; linux-kernel@vger.kernel.org
> Subject: Re: ACPI -- Workaround for broken DSDT
> Importance: High
> 
> 
> From Len Brown on Sunday, 01 February, 2004:
> >this is probably best addressed to acpi-devel@lists.sourceforge.net
> >where people over-ride their BIOS ACPI DSDT all the time.
> >However, there is a reason that it isn't push-button, and that is
> >because we don't want to encourage people to do it.  We'd rather fix
> >Linux where Linux is broken, or get the OEMs to fix their 
> BIOS where the
> >BIOS is broken.
> 
> How does one get a hold of a fixed DSDT?  I've seen postings about
>   how to apply them, but how do they get released?  I'd *love* for
>   Dell to release a fix for my Inspiron 8600 (haven't found a fixed
>   DSDT), or to just get a hold of one.
> 
> *sigh*  When will the vendors support Linux?!
> 
> -Joseph
> 
