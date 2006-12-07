Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967857AbWLGDXg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967857AbWLGDXg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 22:23:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967868AbWLGDXg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 22:23:36 -0500
Received: from outbound-cpk.frontbridge.com ([207.46.163.16]:4076 "EHLO
	outbound1-cpk-R.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S967857AbWLGDXf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 22:23:35 -0500
X-BigFish: VP
X-Server-Uuid: 519AC16A-9632-469E-B354-112C592D09E8
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: [RFC][PATCH 2/2] x86_64: earlyprintk usb debug device
 support.
Date: Wed, 6 Dec 2006 19:20:16 -0800
Message-ID: <5986589C150B2F49A46483AC44C7BCA4907299@ssvlexmb2.amd.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [RFC][PATCH 2/2] x86_64: earlyprintk usb debug device
 support.
Thread-Index: AccYB908AVC39zoPR4GEOmFBP+dm2ABpnSkg
From: "Lu, Yinghai" <yinghai.lu@amd.com>
To: "Greg KH" <gregkh@suse.de>, "Eric W. Biederman" <ebiederm@xmission.com>
cc: "USB development list" <linux-usb-devel@lists.sourceforge.net>,
       "Stefan Reinauer" <stepan@coresystems.de>,
       "Peter Stuge" <stuge-linuxbios@cdy.org>, linux-kernel@vger.kernel.org,
       "Andi Kleen" <ak@suse.de>
X-OriginalArrivalTime: 07 Dec 2006 03:20:17.0701 (UTC)
 FILETIME=[9E77E550:01C719AE]
X-WSS-ID: 696957FB0T02282227-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg,

I wonder why the netconsole could print all boot log from beginning with
buffer. But your usb serial console can not.

YH


