Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264855AbUFDDYS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264855AbUFDDYS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 23:24:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265580AbUFDDYS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 23:24:18 -0400
Received: from fmr12.intel.com ([134.134.136.15]:29599 "EHLO
	orsfmr001.jf.intel.com") by vger.kernel.org with ESMTP
	id S264855AbUFDDYQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 23:24:16 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: bootup command line list
Date: Fri, 4 Jun 2004 11:22:58 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F8403BD5504@PDSMSX403.ccr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: bootup command line list
Thread-Index: AcRJ3MFSXVn2K1VyTYy8nAH7EKMBxwABnAhQ
From: "Zhu, Yi" <yi.zhu@intel.com>
To: "Yaoping Ruan" <yruan@CS.Princeton.EDU>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 04 Jun 2004 03:23:38.0179 (UTC) FILETIME=[53936930:01C449E3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yaoping wrote:
> Could anyone let me know where I can find a full list for
> bootup command line parameters, such as mem=1G, etc? 

Documentation/kernel-parameters.txt
man bootparam

> I'd like to boot a Hyper-threading enabled kernel using only one
> processor on a dual-processor system.

nosmp

> Currently my solution is to physically unplug the secondary CPU.
> 
> Thanks for any suggestion
> 
> -Yaoping

Thanks,
-yi
