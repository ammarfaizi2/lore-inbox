Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262672AbVA0RwU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262672AbVA0RwU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 12:52:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262681AbVA0Rtm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 12:49:42 -0500
Received: from fmr13.intel.com ([192.55.52.67]:16824 "EHLO
	fmsfmr001.fm.intel.com") by vger.kernel.org with ESMTP
	id S262694AbVA0RqJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 12:46:09 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: CELERON D Prescott Step C-0
Date: Thu, 27 Jan 2005 09:45:14 -0800
Message-ID: <88056F38E9E48644A0F562A38C64FB6003DDFFCD@scsmsx403.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: CELERON D Prescott Step C-0
Thread-Index: AcUCHW0clyDsFpdnQ0abJeN3w10xmwCeRTnQ
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: "Robson Roberto Souza Peixoto" <robsonpeixoto@gmail.com>,
       <camilot@terra.com.br>
Cc: <linux-kernel@vger.kernel.org>, "Seth, Rohit" <rohit.seth@intel.com>
X-OriginalArrivalTime: 27 Jan 2005 17:45:15.0630 (UTC) FILETIME=[F58F28E0:01C50497]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Can you please make sure you are running with the latest microcode for
this CPU (you can find it here: http://www.urbanmyth.org/microcode/).
Let me know if the problem still persists.

Thanks,
Venki

>-----Original Message-----
>From: linux-kernel-owner@vger.kernel.org 
>[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of 
>Robson Roberto Souza Peixoto
>Sent: Monday, January 24, 2005 5:59 AM
>To: linux-kernel@vger.kernel.org
>Subject: Re: CELERON D Prescott Step C-0
>
>I have the same problem here too. 
>I using 2.4.25.
>
>Robson.
>
>
>
>On Sat, 22 Jan 2005 18:43:32 Camilo Telles wrote
>
>
>> Sirs,
>
>> There is a bug in the CELERON D Prescott C-0 that prevents this
>> processor to reboot the machine. This processor hangs when you try to
>> reboot the machine. The people from ECS had already released in
>> 2005/01/11 a BIOS update that covers this problem to the motherboard
>> 648FX-A2(PCB:1.0).
>> Here is the update description of the BIOS:
>
><snip>
>
>> Camilo
>-
>To unsubscribe from this list: send the line "unsubscribe 
>linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
