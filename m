Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162733AbWLBCnT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162733AbWLBCnT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 21:43:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162734AbWLBCnT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 21:43:19 -0500
Received: from outbound-fra.frontbridge.com ([62.209.45.174]:17180 "EHLO
	outbound3-fra-R.bigfish.com") by vger.kernel.org with ESMTP
	id S1162733AbWLBCnS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 21:43:18 -0500
X-BigFish: VP
X-Server-Uuid: 519AC16A-9632-469E-B354-112C592D09E8
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: [LinuxBIOS] #57: libusb host program for PLX NET20DC debug
 device
Date: Fri, 1 Dec 2006 18:43:03 -0800
Message-ID: <5986589C150B2F49A46483AC44C7BCA490727C@ssvlexmb2.amd.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [LinuxBIOS] #57: libusb host program for PLX NET20DC debug
 device
Thread-Index: AccVnojdWqMmFJnWT22o/e1MA7Q2oQAG8IDg
From: "Lu, Yinghai" <yinghai.lu@amd.com>
To: ebiederm@xmission.com, "Greg KH" <gregkh@suse.de>
cc: "Stefan Reinauer" <stepan@coresystems.de>,
       "Peter Stuge" <stuge-linuxbios@cdy.org>, linuxbios@linuxbios.org,
       linux-kernel@vger.kernel.org, "Andi Kleen" <ak@suse.de>
X-OriginalArrivalTime: 02 Dec 2006 02:43:04.0790 (UTC)
 FILETIME=[977BF760:01C715BB]
X-WSS-ID: 696E37B20T01919279-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the code.

In LinuxBIOS,
I put usbdevice_direct.c in lib/, and call it from usb2_init in
mcp55_usb2.c

Got 
"No device in debug port"

Waiting for cable, hope to get that cable next Tuesday.

Will create usbdebug_direct_console.c in console/ for linuxbios_ram
code.
also usbdebug_direct_serial.c in pc80/ for cache_as_ram.c


YH



