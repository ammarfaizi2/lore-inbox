Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264288AbUFCOPw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264288AbUFCOPw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 10:15:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264297AbUFCOPw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 10:15:52 -0400
Received: from fmr05.intel.com ([134.134.136.6]:7615 "EHLO hermes.jf.intel.com")
	by vger.kernel.org with ESMTP id S264288AbUFCOPp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 10:15:45 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: idebus setup problem (2.6.7-rc1)
Date: Thu, 3 Jun 2004 22:05:08 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F8403BD54FE@PDSMSX403.ccr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: idebus setup problem (2.6.7-rc1)
Thread-Index: AcRJN6ppTCnOzTUnRtSI0s+stjq+jQAPBdMw
From: "Zhu, Yi" <yi.zhu@intel.com>
To: "Rusty Russell" <rusty@rustcorp.com.au>
Cc: "Bartlomiej Zolnierkiewicz" <B.Zolnierkiewicz@elka.pw.edu.pl>,
       "Auzanneau Gregory" <mls@reolight.net>,
       "Jeff Garzik" <jgarzik@pobox.com>,
       "lkml - Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Andrew Morton" <akpm@osdl.org>
X-OriginalArrivalTime: 03 Jun 2004 14:05:08.0624 (UTC) FILETIME=[C7417900:01C44973]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:
> 
> Dislike this idea.  If you have hundreds of parameters, maybe it's
> supposed to be a PITA? 

What's your idea to make module_param support alterable param
names like ide3=xxx ?

Thanks,
-yi

