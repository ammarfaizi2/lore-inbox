Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268407AbUHXWCA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268407AbUHXWCA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 18:02:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268404AbUHXV7F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 17:59:05 -0400
Received: from fmr06.intel.com ([134.134.136.7]:40641 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S267450AbUHXV6h convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 17:58:37 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: EINTR causes sigwaitinfo and pthread_kill to become hosed
Date: Tue, 24 Aug 2004 14:58:13 -0700
Message-ID: <194B303F2F7B534594F2AB2D87269D9F0267400B@orsmsx408>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: EINTR causes sigwaitinfo and pthread_kill to become hosed
Thread-Index: AcSKIjdmoY1MsvizR/2JAceK1OkTYgAAsTWw
From: "Wilkerson, Bryan P" <Bryan.P.Wilkerson@intel.com>
To: "Roland McGrath" <roland@redhat.com>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 24 Aug 2004 21:58:06.0748 (UTC) FILETIME=[6FCF0DC0:01C48A25]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Roland McGrath [mailto:roland@redhat.com] wrote:

> Have you reproduced this on 2.6.8.1?  I'm not seeing it so far.

Thanks for looking at it.  I have not tried it on 2.6.8.1.  I Will try
as soon as time permits.  So far I've tried 2.4.21-99, 2.6.5-7.97 and
RHEL4 Alpha 3 (don't have the disk loaded in my system right now to tell
you the kernel version).


