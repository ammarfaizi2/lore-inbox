Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758682AbWLIDWj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758682AbWLIDWj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Dec 2006 22:22:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758359AbWLIDWj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 22:22:39 -0500
Received: from outbound-cpk.frontbridge.com ([207.46.163.16]:57483 "EHLO
	outbound2-cpk-R.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758661AbWLIDWh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 22:22:37 -0500
X-BigFish: VP
X-Server-Uuid: 519AC16A-9632-469E-B354-112C592D09E8
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: [LinuxBIOS] [linux-usb-devel] [RFC][PATCH 0/2] x86_64 Early
 usb debug port support.
Date: Fri, 8 Dec 2006 19:16:09 -0800
Message-ID: <5986589C150B2F49A46483AC44C7BCA49072AB@ssvlexmb2.amd.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [LinuxBIOS] [linux-usb-devel] [RFC][PATCH 0/2] x86_64
 Early usb debug port support.
Thread-Index: AccanIC/YU7gSWmSQH+79HUszuzpqAAo1STA
From: "Lu, Yinghai" <yinghai.lu@amd.com>
To: ebiederm@xmission.com
cc: "Greg KH" <gregkh@suse.de>, "Peter Stuge" <stuge-linuxbios@cdy.org>,
       linux-usb-devel@lists.sourceforge.net,
       "Stefan Reinauer" <stepan@coresystems.de>, linux-kernel@vger.kernel.org,
       linuxbios@linuxbios.org, "Andi Kleen" <ak@suse.de>,
       "David Brownell" <david-b@pacbell.net>
X-OriginalArrivalTime: 09 Dec 2006 03:16:10.0423 (UTC)
 FILETIME=[5FE7C470:01C71B40]
X-WSS-ID: 6964F5F00T02460125-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----Original Message-----
From: ebiederm@xmission.com [mailto:ebiederm@xmission.com] 
Sent: Thursday, December 07, 2006 11:42 PM
>> With Eric code in LinuxBIOS, it will report "No device found in debug
>> port"
>Hmm.  At least this is partial progress :)

It works in LinuxBIOS now. It will loop all connected port and find
debug device.
Will check in the code together with MCP55.

YH


