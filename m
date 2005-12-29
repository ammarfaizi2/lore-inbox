Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750739AbVL2OqP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750739AbVL2OqP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 09:46:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750738AbVL2OqO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 09:46:14 -0500
Received: from general.keba.co.at ([193.154.24.243]:12262 "EHLO
	helga.keba.co.at") by vger.kernel.org with ESMTP id S1750739AbVL2OqO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 09:46:14 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: SLAB-related panic in 2.6.15-rc7-rt1 on ARM
Date: Thu, 29 Dec 2005 15:46:11 +0100
Message-ID: <AAD6DA242BC63C488511C611BD51F367323306@MAILIT.keba.co.at>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: SLAB-related panic in 2.6.15-rc7-rt1 on ARM
Thread-Index: AcYMhcht8u5HgRLTT1qgK0ThGwgApAAABuqw
From: "kus Kusche Klaus" <kus@keba.com>
To: "Pekka J Enberg" <penberg@cs.Helsinki.FI>
Cc: "Ingo Molnar" <mingo@elte.hu>,
       "linux-kernel" <linux-kernel@vger.kernel.org>, <clameter@sgi.com>,
       <mpm@selenic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Pekka J Enberg
> On Thu, 29 Dec 2005, kus Kusche Klaus wrote:
> > > From: Pekka J Enberg
> > > On Thu, 29 Dec 2005, kus Kusche Klaus wrote:
> > > > (note the very early BUG and two "MM: invalid domain"):
> You need someone who speaks ARM for these.

As long as the system works and they don't cause trouble,
I can live with them...

> Yes, the bug is not -rt related. The patch was against 
> vanilla. Christoph, 
> do you know who did the ARM bits for NUMA-aware page allocator?

NUMA ARM's? I guess there are not too many of them out there...

-- 
Klaus Kusche                 (Software Development - Control Systems)
KEBA AG             Gewerbepark Urfahr, A-4041 Linz, Austria (Europe)
Tel: +43 / 732 / 7090-3120                 Fax: +43 / 732 / 7090-6301
E-Mail: kus@keba.com                                WWW: www.keba.com
