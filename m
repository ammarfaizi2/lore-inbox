Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262019AbVFGWgh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262019AbVFGWgh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 18:36:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262020AbVFGWgg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 18:36:36 -0400
Received: from scl-ims.phoenix.com ([216.148.212.222]:48945 "EHLO
	scl-exch2k.phoenix.com") by vger.kernel.org with ESMTP
	id S261997AbVFGWgP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 18:36:15 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: stupid SATA questions
Date: Tue, 7 Jun 2005 15:36:08 -0700
Message-ID: <0EF82802ABAA22479BC1CE8E2F60E8C3216B5E@scl-exch2k3.phoenix.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: stupid SATA questions
Thread-Index: AcVrsKg6ET2G9avvTkixpRAq6IcXYQAADR9Q
From: "Aleksey Gorelov" <Aleksey_Gorelov@Phoenix.com>
To: "Jeff Garzik" <jgarzik@pobox.com>
Cc: "Kumar Gala" <kumar.gala@freescale.com>,
       "Linux Kernel list" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 07 Jun 2005 22:36:12.0443 (UTC) FILETIME=[4EBEAEB0:01C56BB1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
>From: Jeff Garzik [mailto:jgarzik@pobox.com] 
>Aleksey Gorelov wrote:
>>  
>> 
>>>From: linux-kernel-owner@vger.kernel.org 
>>>[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Jeff Garzik
>>>Sent: Tuesday, June 07, 2005 11:01 AM
>>>To: Kumar Gala
>>>Cc: Linux Kernel list
>>>Subject: Re: stupid SATA questions
>>>
>>>Kumar Gala wrote:
>>>
>>>>These questions were posed to me and I was hoping someone 
>would have 
>>>>better knowledge about the works and usage of SATA then I 
>>>
>>>do.  All of 
>>>
>>>>these questions are around understanding how important the 
>>>
>>>performance 
>>>
>>>>of PIO mode is.
>>>>
>>>>How often would one run in PIO mode?  Why would one run in PIO mode?
>>>
>>>Never.  No idea.  :)
>> 
>> 
>> Some BIOSes/option ROMs do. Especially SATA RAID ones.
>> But unless you are using BIOS interrupts... 
>
>It doesn't matter what BIOS does, Linux SATA drivers don't use 
>the BIOS.

I probably missed something, but I did not see LINUX SATA DRIVERS in the
original question, I just saw SATA. Well, never mind then ;)

Aleks.
