Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264164AbTE0U7I (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 16:59:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264168AbTE0U7I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 16:59:08 -0400
Received: from fmr05.intel.com ([134.134.136.6]:44785 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S264164AbTE0U7F convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 16:59:05 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: [PATCH] Make ACPI compile again on 64bit/gcc 3.3 II
Date: Tue, 27 May 2003 14:12:17 -0700
Message-ID: <F760B14C9561B941B89469F59BA3A847E96EE0@orsmsx401.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] Make ACPI compile again on 64bit/gcc 3.3 II
Thread-Index: AcMkk5RObjoY7QZhQ12Q9XePWRY+oQAAPqZQ
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "Andi Kleen" <ak@suse.de>
Cc: <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 27 May 2003 21:12:17.0754 (UTC) FILETIME=[A7539BA0:01C32494]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Andi Kleen [mailto:ak@suse.de] 
> > > On looking again these functions are not used at all.
> > > How about just removing them? 
> > 
> > We will remove them for the next release.
> 
> But can you merge one of the patches for now to make it compile again?
> 
> -Andi

I thought Linus already took your patch, so that'll work for now, yes?

-- Andy
