Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266981AbTBLJtK>; Wed, 12 Feb 2003 04:49:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266987AbTBLJtK>; Wed, 12 Feb 2003 04:49:10 -0500
Received: from ishtar.tlinx.org ([64.81.58.33]:42935 "EHLO ishtar.tlinx.org")
	by vger.kernel.org with ESMTP id <S266981AbTBLJtJ>;
	Wed, 12 Feb 2003 04:49:09 -0500
From: "LA Walsh" <law@tlinx.org>
To: <linux-kernel@vger.kernel.org>
Subject: RE: lsm truly "generic" allowing complete choice?  Clean? Simple? Idon't think so.
Date: Wed, 12 Feb 2003 01:58:53 -0800
Message-ID: <004301c2d27d$5997c9e0$1403a8c0@sc.tlinx.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
In-Reply-To: <200302121010.56366.russell@coker.com.au>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Russell Coker
> linux-kernel mailing list removed from the CC list (again), they've 
> probably heard too much of this discussion already.  
---
	It was isolation away from the mainline kernel list that allowed
the current patchwork design.  Attempts to clarify the LSM list charter
which ended up on lkml resulted in movements to silence those 
questioning the emperor's new clothes (or lack thereof).  LSM project
members want their changes in the kernel code *today*.  It is appropriate
to discuss design methodolgy on the kernel list since design
methodology discussion was forbidden on lkml as was any interaction 
with the linux community.  Quite frankly, the brown-nosing, back-slapping
politics really put a bitter taste on things that were naively believed
to be based more on technocracy than making people 'look good' and
commercial self-interest.

> If making the DAC code a module slows down non-LSM servers 
> and takes a lot of 
> programmer time to implement, is it a useful effort?
---

	It was already done -- the mainline kernel modules were done in
about 2 person-months of motivated programmer time.   There was no measured slowdown of non-LSM servers.  Changes done earlier by
the same project
lead of that project had all changes in the mainline kernel code compile
to nothing when compiled out.  Performance was a consideration in the
implementation.

-l

