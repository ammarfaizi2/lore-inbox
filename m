Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267252AbUBMWYy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 17:24:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267254AbUBMWYy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 17:24:54 -0500
Received: from msgbas1x.cos.agilent.com ([192.25.240.36]:63977 "EHLO
	msgbas1x.cos.agilent.com") by vger.kernel.org with ESMTP
	id S267252AbUBMWYw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 17:24:52 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: what is the best 2.6.2 kernel code?
Date: Fri, 13 Feb 2004 15:24:51 -0700
Message-ID: <0A78D025ACD7C24F84BD52449D8505A15A80CF@wcosmb01.cos.agilent.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: what is the best 2.6.2 kernel code?
Thread-Index: AcPygDLJw3y1PzfqRoOjZAB7sZ7/nw==
From: <yiding_wang@agilent.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 13 Feb 2004 22:24:51.0811 (UTC) FILETIME=[32C67B30:01C3F280]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I downloaded kernel linux-2.6.2.tar.gz and patch-2.6.2.bz2  from kernel source.  Both files are dated 03-Feb.-2004.   

Building new kernel from the source failed on fs/proc/array.o.  Patching with patch file will have numerous warning message which says "Reversed patch detected! Assume -R [n]".  From messages, it looks like the patch file is outdated.  However, without patch, kernel failed on building.  Running patch with force option also failed on file patching.

What is the best working 2.6.2 kernel and patch I can get from source tree?

Many thanks!

Eddie
