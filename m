Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261786AbVDEPbQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261786AbVDEPbQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 11:31:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261773AbVDEPan
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 11:30:43 -0400
Received: from scl-ims.phoenix.com ([216.148.212.222]:22303 "EHLO
	scl-ims.phoenix.com") by vger.kernel.org with ESMTP id S261786AbVDEPaS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 11:30:18 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: mmap() and ioctl()
Date: Tue, 5 Apr 2005 08:30:11 -0700
Message-ID: <5F106036E3D97448B673ED7AA8B2B6B301D29023@scl-exch2k.phoenix.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: mmap() and ioctl()
Thread-Index: AcU5TDCC79jw2MU6TIS6t4hIhHyGIQAqAnfA
From: "Aleksey Gorelov" <Aleksey_Gorelov@Phoenix.com>
To: "Matthew Dharm" <mdharm-kernel@one-eyed-alien.net>,
       "Richard B. Johnson" <linux-os@analogic.com>
Cc: "Kernel Developer List" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 05 Apr 2005 15:30:15.0269 (UTC) FILETIME=[5D752950:01C539F4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 >-----Original Message-----
>From: linux-kernel-owner@vger.kernel.org 
>[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Matthew Dharm
>Sent: Monday, April 04, 2005 12:20 PM
>To: Richard B. Johnson
>Cc: Kernel Developer List
>Subject: Re: mmap() and ioctl()
>

[snip]

>That's an interesting concept, and one I'm not familiar with.  
>Any useful
>pointers (beyond UTSL)?  I'll admit to being much more 
>familiar with SCSI
>and USB internals than I am with something like device-layer 
>interfacing.
Try this:

http://lwn.net/Kernel/LDD3/

Aleks.
