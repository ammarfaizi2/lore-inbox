Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268911AbTGORHQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 13:07:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269020AbTGORHQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 13:07:16 -0400
Received: from fmr05.intel.com ([134.134.136.6]:19652 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S268911AbTGORHP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 13:07:15 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: ACPI patches updated (20030714)
Date: Tue, 15 Jul 2003 10:21:33 -0700
Message-ID: <F760B14C9561B941B89469F59BA3A8470255EE8F@orsmsx401.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: ACPI patches updated (20030714)
Thread-Index: AcNK8+ivPyG6Hos+RMKqMJI5pF1NfwAAJYJQ
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "Hugh Dickins" <hugh@veritas.com>
Cc: "ACPI-Devel mailing list" <acpi-devel@lists.sourceforge.net>,
       <linux-kernel@vger.kernel.org>, "Len Brown" <lenb417@yahoo.com>
X-OriginalArrivalTime: 15 Jul 2003 17:21:54.0489 (UTC) FILETIME=[96428290:01C34AF5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Hugh Dickins [mailto:hugh@veritas.com] 
> > Make it so acpismp=force works (reported by Andrew Morton)
> 
> But we don't want "acpismp=force" to work, it now serves no purpose
> but to confuse.  May I push again to Marcelo my patch you acked
> before, which removes it completely?  I had been waiting to say it's
> in 2.6, but Andrew didn't push it from 2.5-mm into 2.6 - any reason?
> 
> Whereas we would still like "noht" to work, but it's now beyond me.

That patch was sitting in my bk tree but yeah it's kinda stale. Len
Brown was going to completely redo all this stuff, so Hugh if you have a
need for your fix in the interim then great feel free to push, but there
is a more comprehensive fix also in the works.

Regards -- Andy
