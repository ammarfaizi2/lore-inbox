Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267388AbUHJBy3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267388AbUHJBy3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 21:54:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267390AbUHJBy2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 21:54:28 -0400
Received: from scl-ims.phoenix.com ([216.148.212.222]:12074 "EHLO
	scl-ims.phoenix.com") by vger.kernel.org with ESMTP id S267388AbUHJBy2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 21:54:28 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [linux-usb-devel] USB shared interrupt problem
Date: Mon, 9 Aug 2004 18:54:27 -0700
Message-ID: <5F106036E3D97448B673ED7AA8B2B6B3015B60B7@scl-exch2k.phoenix.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [linux-usb-devel] USB shared interrupt problem
thread-index: AcR79ec/MJ8wmuxqQ3Kpx+bN4lP3ewChqOXw
From: "Aleksey Gorelov" <Aleksey_Gorelov@Phoenix.com>
To: "Pete Zaitcev" <zaitcev@redhat.com>
Cc: <linux-kernel@vger.kernel.org>, <linux-usb-devel@lists.sourceforge.net>
X-OriginalArrivalTime: 10 Aug 2004 01:54:27.0330 (UTC) FILETIME=[F7E5E620:01C47E7C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>I have a patch which prevents SMM BIOS from doing this to us
>by requesting unconditional handoff (it comes from Vojtech @SuSE,
>modified by John Stulz from IBM for 2.4). 

Thanks. This patch works fine for me.

Aleks.
