Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266112AbSKFVM1>; Wed, 6 Nov 2002 16:12:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266122AbSKFVM1>; Wed, 6 Nov 2002 16:12:27 -0500
Received: from ztxmail03.ztx.compaq.com ([161.114.1.207]:7439 "EHLO
	ztxmail03.ztx.compaq.com") by vger.kernel.org with ESMTP
	id <S266112AbSKFVM0> convert rfc822-to-8bit; Wed, 6 Nov 2002 16:12:26 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: 2.5.46 and make menuconfig weirdness
Date: Wed, 6 Nov 2002 15:18:59 -0600
Message-ID: <45B36A38D959B44CB032DA427A6E106401281519@cceexc18.americas.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.5.46 and make menuconfig weirdness
Thread-Index: AcKF2Si1q1LxNMAKSVWzrRfqwrr/iQAAOBxA
From: "Cameron, Steve" <Steve.Cameron@hp.com>
To: "Roman Zippel" <zippel@linux-m68k.org>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 06 Nov 2002 21:19:00.0174 (UTC) FILETIME=[1FBE86E0:01C285DA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel wrote:

> Have you modified a Kconfig somewhere? Look for open strings, 
> the scanner 
> simply exits when it finds one (that's also fixed here).

Yep.  That was it.  thanks.  -- steve
