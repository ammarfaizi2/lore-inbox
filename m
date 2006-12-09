Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1947635AbWLIBVG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1947635AbWLIBVG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Dec 2006 20:21:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1947653AbWLIBVF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 20:21:05 -0500
Received: from outbound-cpk.frontbridge.com ([207.46.163.16]:6765 "EHLO
	outbound2-cpk-R.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1947647AbWLIBVC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 20:21:02 -0500
X-BigFish: VP
X-Server-Uuid: 519AC16A-9632-469E-B354-112C592D09E8
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: [RFC][PATCH 2/2] x86_64: earlyprintk usb debug device
 support.
Date: Fri, 8 Dec 2006 17:20:11 -0800
Message-ID: <5986589C150B2F49A46483AC44C7BCA49072AA@ssvlexmb2.amd.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [RFC][PATCH 2/2] x86_64: earlyprintk usb debug device
 support.
Thread-Index: AccbL/bH6FKuIb6jQt+ZBYsCOSg2yQAABC8g
From: "Lu, Yinghai" <yinghai.lu@amd.com>
To: "Greg KH" <gregkh@suse.de>
cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       "USB development list" <linux-usb-devel@lists.sourceforge.net>,
       "Stefan Reinauer" <stepan@coresystems.de>,
       "Peter Stuge" <stuge-linuxbios@cdy.org>, linux-kernel@vger.kernel.org,
       "Andi Kleen" <ak@suse.de>
X-OriginalArrivalTime: 09 Dec 2006 01:20:13.0419 (UTC)
 FILETIME=[2D3533B0:01C71B30]
X-WSS-ID: 6964D0C70T02456980-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


-----Original Message-----
From: Greg KH [mailto:gregkh@suse.de] 
Sent: Friday, December 08, 2006 5:17 PM

>Buffer size?  flow control?  the fact that the buffer has already
>overflowed?  Who knows, don't trust usb-serial as a real "console"
>please :)

I set buffer size to 128k, and can get all.

Thanks

YH


