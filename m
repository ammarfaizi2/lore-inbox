Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031704AbWLAS3i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031704AbWLAS3i (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 13:29:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031705AbWLAS3i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 13:29:38 -0500
Received: from outbound-cpk.frontbridge.com ([207.46.163.16]:49607 "EHLO
	outbound1-cpk-R.bigfish.com") by vger.kernel.org with ESMTP
	id S1031704AbWLAS3h convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 13:29:37 -0500
X-BigFish: VP
X-Server-Uuid: 519AC16A-9632-469E-B354-112C592D09E8
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: [LinuxBIOS] #57: libusb host program for PLX NET20DC debug
 device
Date: Fri, 1 Dec 2006 10:26:19 -0800
Message-ID: <5986589C150B2F49A46483AC44C7BCA4907273@ssvlexmb2.amd.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [LinuxBIOS] #57: libusb host program for PLX NET20DC debug
 device
Thread-Index: AccVQCm9i5OF281tRHu1BZ4T7nb5EAAM7HgQAABUPWA=
From: "Lu, Yinghai" <yinghai.lu@amd.com>
To: "Greg KH" <gregkh@suse.de>, "Stefan Reinauer" <stepan@coresystems.de>,
       "Peter Stuge" <stuge-linuxbios@cdy.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>
cc: linuxbios@linuxbios.org, linux-kernel@vger.kernel.org
X-OriginalArrivalTime: 01 Dec 2006 18:26:20.0903 (UTC)
 FILETIME=[32FBB770:01C71576]
X-WSS-ID: 696EAC460T01889480-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----Original Message-----
From: Lu, Yinghai 

>To my understanding, you don't need to waiting for Eric's code.
>You can use the cable on two systems without debug port support.
>So just extend the program to make it can write the data too.

Greg,

Anyone is working on creating one usb_serial_driver for USB debug device
without
using host debug port?

YH


