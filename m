Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262562AbUCCTr0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 14:47:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262573AbUCCTqu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 14:46:50 -0500
Received: from fmr10.intel.com ([192.55.52.30]:16610 "EHLO
	fmsfmr003.fm.intel.com") by vger.kernel.org with ESMTP
	id S262562AbUCCTpJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 14:45:09 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: [CFT][PATCH] 2.6.4-rc1 remove x86 boot page tables
Date: Wed, 3 Mar 2004 11:45:04 -0800
Message-ID: <D36CE1FCEFD3524B81CA12C6FE5BCAB002FFE9B4@fmsmsx406.fm.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [CFT][PATCH] 2.6.4-rc1 remove x86 boot page tables
Thread-Index: AcQBTVpSqVutMaCFRbC3JErUp9XzdAABWGXg
From: "Tolentino, Matthew E" <matthew.e.tolentino@intel.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 03 Mar 2004 19:45:04.0860 (UTC) FILETIME=[065B19C0:01C40158]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Stupid question.  What is efi doing in arch/i386 anyway?

Not a stupid question at all. Despite the recent announcement, 
efi is still working its way into x86 systems.  I think that 
decision lies with OEMs.  I believe some are already out there...  

> All of the to be production efi x86 systems I have heard of support
> x86-64.  So shouldn't it be 64bit calls that we need to worry about?

Not necessarily, although some systems (such as servers) will 
indeed have support for x86-64.  I've just started looking at what 
support needs to added for x86-64, in terms of efi, since I 
learned about the announcement via cnet as well...  ;-(

matt 

