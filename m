Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932162AbWGGSdt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932162AbWGGSdt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 14:33:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751225AbWGGSdt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 14:33:49 -0400
Received: from outbound-cpk.frontbridge.com ([207.46.163.16]:19227 "EHLO
	outbound2-cpk-R.bigfish.com") by vger.kernel.org with ESMTP
	id S1751224AbWGGSds convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 14:33:48 -0400
X-BigFish: V
X-Server-Uuid: 5FC0E2DF-CD44-48CD-883A-0ED95B391E89
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: [discuss] Re: [PATCH] Allow all Opteron processors to
 change pstate at same time
Date: Fri, 7 Jul 2006 12:36:20 -0500
Message-ID: <84EA05E2CA77634C82730353CBE3A84303218E99@SAUSEXMB1.amd.com>
In-Reply-To: <p73fyhdpqe1.fsf@verdi.suse.de>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [discuss] Re: [PATCH] Allow all Opteron processors to
 change pstate at same time
Thread-Index: Acahvmrm3RpL0cJ7Qb+6QjSqeqjUbgALVEYQ
From: "Langsdorf, Mark" <mark.langsdorf@amd.com>
To: ak@suse.de
cc: discuss@x86-64.org, linux-kernel@vger.kernel.org,
       cpufreq@lists.linux.org.uk
X-OriginalArrivalTime: 07 Jul 2006 17:36:21.0655 (UTC)
 FILETIME=[DC918A70:01C6A1EB]
X-WSS-ID: 68B0441F27K15869328-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > the "powernow-k8.tscsync=1" options enables simeltameous 
> transitions.  
> > Other options are necessary to force the use of TSC as a 
> gtod source.
> > 
> > This patch should apply cleanly to the 2.6.18-rc1 kernel.
> 
> Your patch seems to be ^M damaged.

I'll smack my mailer around again.  Sorry about that.
 
> I'm still dubious if the result is really correct if the 
> hardware wasn't designed to guarantee synchronous TSC operation.
> 
> Can you do the following test please? 

We'll try to have the results back by Monday evening.

-Mark Langsdorf
AMD, Inc.


