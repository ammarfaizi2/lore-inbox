Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945971AbWKJCJi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945971AbWKJCJi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 21:09:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945969AbWKJCJi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 21:09:38 -0500
Received: from outbound-fra.frontbridge.com ([62.209.45.174]:33834 "EHLO
	outbound2-fra-R.bigfish.com") by vger.kernel.org with ESMTP
	id S1945965AbWKJCJh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 21:09:37 -0500
X-BigFish: VP
X-Server-Uuid: 89466532-923C-4A88-82C1-66ACAA0041DF
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: 2.6.19-rc5 x86_64 irq 22: nobody cared
Date: Thu, 9 Nov 2006 18:09:21 -0800
Message-ID: <5986589C150B2F49A46483AC44C7BCA49071D4@ssvlexmb2.amd.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.19-rc5 x86_64 irq 22: nobody cared
Thread-Index: AccD4bFW04ny4Z9NSoKoOcgHJ957OwAiufpA
From: "Lu, Yinghai" <yinghai.lu@amd.com>
To: "Olivier Nicolas" <olivn@trollprod.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>
cc: "Adrian Bunk" <bunk@stusta.de>, "Stephen Hemminger" <shemminger@osdl.org>,
       "Takashi Iwai" <tiwai@suse.de>, "Jaroslav Kysela" <perex@suse.cz>,
       linux-kernel@vger.kernel.org, gregkh@suse.de,
       linux-pci@atrey.karlin.mff.cuni.cz, len.brown@intel.com,
       linux-acpi@vger.kernel.org, "Andrew Morton" <akpm@osdl.org>,
       "Linus Torvalds" <torvalds@osdl.org>
X-OriginalArrivalTime: 10 Nov 2006 02:09:23.0043 (UTC)
 FILETIME=[3D575B30:01C7046D]
X-WSS-ID: 694D00D81AO1248721-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric,

Can you confirm:
>From 2.6.19-rc1, the irq for devices that using io-apic will not change
between pci=routeirq and not.

Olivier,
Can you send lspci -vvxxx for pci=routeirq too?

YH




