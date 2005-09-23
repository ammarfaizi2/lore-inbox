Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751179AbVIWTX4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751179AbVIWTX4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 15:23:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751180AbVIWTX4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 15:23:56 -0400
Received: from ausc60pc101.us.dell.com ([143.166.85.206]:47252 "EHLO
	ausc60pc101.us.dell.com") by vger.kernel.org with ESMTP
	id S1751179AbVIWTXz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 15:23:55 -0400
X-IronPort-AV: i="3.97,141,1125896400"; 
   d="scan'208"; a="316870491:sNHT42142064"
X-MIMEOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: FW: [patch 2.6.14-rc2] dell_rbu: changes in packet update mechanism
Date: Fri, 23 Sep 2005 14:23:54 -0500
Message-ID: <597A2BC19EDD3C458F841E8724E92D4B973E1A@ausx3mps301.aus.amer.dell.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: FW: [patch 2.6.14-rc2] dell_rbu: changes in packet update mechanism
Thread-index: AcXAc6Jz7xk4ckloT+KpnsGhkHFXggAAEU2w
From: <Abhay_Salunke@Dell.com>
To: <rdunlap@xenotime.net>
Cc: <linux-kernel@vger.kernel.org>, <akpm@osdl.org>
X-OriginalArrivalTime: 23 Sep 2005 19:23:55.0197 (UTC) FILETIME=[569FA6D0:01C5C074]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> > Resending...for some reason the earlier email didn't go through.
> 
> probably because it's a very malformed patch (according to
> 'patch').
> 
> It's all line-wrapped in odd places.  Try again -- maybe
> learn & copy what Matt does for email.
> 
> > @@ -35,6 +35,7 @@ The driver load creates the following di
> >  /sys/class/firmware/dell_rbu/data
> >  /sys/devices/platform/dell_rbu/image_type
> >  /sys/devices/platform/dell_rbu/data
> > +/sys/devices/platform/dell_rbu/packet_size
> >
> >  The driver supports two types of update mechanism; monolithic and
> > packetized.
> >  These update mechanism depends upon the BIOS currently running on
the
> > system.
> 
> For example, the patch meant to add one line above, but there
> are actually 9 lines in that patch block (not 7).
Alright, it didn't go through using mutt and hence tried outlook :-(
