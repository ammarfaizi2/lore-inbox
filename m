Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262707AbUKRKG0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262707AbUKRKG0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 05:06:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262712AbUKRKGZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 05:06:25 -0500
Received: from mta2.cl.cam.ac.uk ([128.232.0.14]:38360 "EHLO mta2.cl.cam.ac.uk")
	by vger.kernel.org with ESMTP id S262707AbUKRKGF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 05:06:05 -0500
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: [patch 2] Xen core patch : arch_free_page return value
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
Date: Thu, 18 Nov 2004 10:05:50 -0000
Message-ID: <A95E2296287EAD4EB592B5DEEFCE0E9D122E52@liverpoolst.ad.cl.cam.ac.uk>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [patch 2] Xen core patch : arch_free_page return value
Thread-Index: AcTNT5gd2iFihJ4ySnKiPdcaUyh0CQABPmcw
From: "Ian Pratt" <m+Ian.Pratt@cl.cam.ac.uk>
To: "Andrew Morton" <akpm@osdl.org>, "Keir Fraser" <Keir.Fraser@cl.cam.ac.uk>
Cc: <haveblue@us.ibm.com>, <Ian.Pratt@cl.cam.ac.uk>,
       <linux-kernel@vger.kernel.org>, <Keir.Fraser@cl.cam.ac.uk>,
       <Christian.Limpach@cl.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Is Xen using PG_arch_1?  If not, it can be used for this.

No, we're not. This sounds like an excellent soloution. 

We'll resync all the patches with the latest snapshot and then re-submit
the lot.

Sorry about the tabs-to-spaces screwup. We forwarded the patches around
so many different people for comment before sending them to lkml that
somewhere along the line something bad happned.

Ian
