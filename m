Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1751420AbWFEU33@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751420AbWFEU33 (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 16:29:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751422AbWFEU33
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 16:29:29 -0400
Received: from mga01.intel.com ([192.55.52.88]:64290 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1751420AbWFEU32 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 16:29:28 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: ANNOUNCE: Linux UWB and Wireless USB project
Date: Mon, 5 Jun 2006 13:31:52 -0700
Message-ID: <F989B1573A3A644BAB3920FBECA4D25A063F1984@orsmsx407>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: ANNOUNCE: Linux UWB and Wireless USB project
Thread-Index: AcaHSuroMwJlR8jeRuiTS4Kkb/lFIAARqsMg
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "Pavel Machek" <pavel@ucw.cz>,
        "Inaky Perez-Gonzalez" <inaky@linux.intel.com>
Cc: <linux-kernel@vger.kernel.org>, <linux-usb-devel@lists.sourceforge.net>
X-OriginalArrivalTime: 05 Jun 2006 20:29:01.0711 (UTC) FILETIME=[AE6CA1F0:01C688DE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From: Pavel Machek [mailto:pavel@ucw.cz]
>
>> Intel is pleased to announce the launch of a project to
>> implement Linux kernel support for upcoming hardware that
>> complies with the WiMedia Ultra Wide Band (UWB) and Wireless
>> USB standards.
>
>Does wireless usb also supply power as wired USB does? ;-)

Hmmm...business idea :)

>> UWB is a high-bandwidth, low-power, point-to-point radio
>> technology using a wide spectrum (3.1-10.6HGz).  It is
>
>How much power is low power?

For what I know (and I could be wrong) max is around -40dBm/MHz 
in the US. I am no expert in the nitty-gritty radio details, but 
I've been told that is 3000 times less emissions than a common 
cellphone, around .1 uW? [this is where my knowledge about radio
*really* fades].

>> You are welcome to contribute!
>
>Is there any hardware available?

I think some companies are starting to make PDKs available this
summer, but YMMV.

-- Inaky
