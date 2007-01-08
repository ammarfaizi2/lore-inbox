Return-Path: <linux-kernel-owner+w=401wt.eu-S932105AbXAHU5G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932105AbXAHU5G (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 15:57:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932649AbXAHU5F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 15:57:05 -0500
Received: from outbound-cpk.frontbridge.com ([207.46.163.16]:6292 "EHLO
	outbound2-cpk-R.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932105AbXAHU5D convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 15:57:03 -0500
X-BigFish: VP
X-Server-Uuid: 89466532-923C-4A88-82C1-66ACAA0041DF
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: [PATCH 4/4] x86_64 ioapic: Improve the heuristics for when
 check_timer fails.
Date: Mon, 8 Jan 2007 12:53:39 -0800
Message-ID: <5986589C150B2F49A46483AC44C7BCA490736A@ssvlexmb2.amd.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 4/4] x86_64 ioapic: Improve the heuristics for when
 check_timer fails.
Thread-Index: AcczZm/qGipzI8nwTpKIPAtiYi6UngAAGmJw
From: "Lu, Yinghai" <yinghai.lu@amd.com>
To: ebiederm@xmission.com
cc: "Linus Torvalds" <torvalds@osdl.org>,
       "Tobias Diedrich" <ranma+kernel@tdiedrich.de>,
       "Andrew Morton" <akpm@osdl.org>, "Adrian Bunk" <bunk@stusta.de>,
       "Andi Kleen" <ak@suse.de>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 08 Jan 2007 20:53:39.0895 (UTC)
 FILETIME=[13215C70:01C73367]
X-WSS-ID: 69BC70D91WC4151554-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----Original Message-----
From: ebiederm@xmission.com [mailto:ebiederm@xmission.com] 
Sent: Monday, January 08, 2007 12:47 PM
To: Lu, Yinghai
Cc: Linus Torvalds; Tobias Diedrich; Andrew Morton; Adrian Bunk; Andi
Kleen; Linux Kernel Mailing List
Subject: Re: [PATCH 4/4] x86_64 ioapic: Improve the heuristics for when
check_timer fails.


>So that doesn't invalidate the generic test.  I'm going to go dig
>out what little information I have and see if I can stair at the
>register definition.

Someone said we can that info about that reg in Kernel. And only
firmware can use that.

YH


