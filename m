Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261348AbSJDEn6>; Fri, 4 Oct 2002 00:43:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261477AbSJDEn6>; Fri, 4 Oct 2002 00:43:58 -0400
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:38798 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id <S261348AbSJDEn5>; Fri, 4 Oct 2002 00:43:57 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.5762.3
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPartTM-000-c07ddc93-f071-46d1-8c25-6cd87f4c6af8"
Subject: Problem loading tigon3 driver
Date: Fri, 4 Oct 2002 10:19:16 +0530
Message-ID: <72D09F11CC09B645ADE2890F6B442FD84A7D78@blr-m3-msg.wipro.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Problem loading tigon3 driver
Thread-Index: AcJrYWPI3gfNltjeTDKUaRxiHqkW2Q==
X-Priority: 1
Importance: high
From: "Ganesh  S" <ganesh.subramaniam@wipro.com>
To: "Linux-Kernel" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 04 Oct 2002 04:49:16.0404 (UTC) FILETIME=[64A09340:01C26B61]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.

------=_NextPartTM-000-c07ddc93-f071-46d1-8c25-6cd87f4c6af8
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

I have compiled the linux 2.4.19 kernel for my x86 system (PC). I am
using the tigon3 NIC card in the system which uses the Broadcom BCM5700
MAC chip. When I try to load the driver written by David S. Miller and
Jeff Garzik for this card (tg3.o), I get the following error:

"Problem fetching invariants of chip"

Can someone figure out what the problem could be?

- Ganesh



------=_NextPartTM-000-c07ddc93-f071-46d1-8c25-6cd87f4c6af8
Content-Type: text/plain;
	name="Wipro_Disclaimer.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="Wipro_Disclaimer.txt"

**************************Disclaimer**************************************************    
 
 Information contained in this E-MAIL being proprietary to Wipro Limited is 'privileged' 
and 'confidential' and intended for use only by the individual or entity to which it is 
addressed. You are notified that any use, copying or dissemination of the information 
contained in the E-MAIL in any manner whatsoever is strictly prohibited.

****************************************************************************************

------=_NextPartTM-000-c07ddc93-f071-46d1-8c25-6cd87f4c6af8--
