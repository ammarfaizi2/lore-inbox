Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262015AbTIYXFT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 19:05:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262013AbTIYXFS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 19:05:18 -0400
Received: from fmr09.intel.com ([192.52.57.35]:43218 "EHLO hermes.hd.intel.com")
	by vger.kernel.org with ESMTP id S261873AbTIYXFM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 19:05:12 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: Intel PRO/1000 NIC
Date: Thu, 25 Sep 2003 16:05:03 -0700
Message-ID: <C6F5CF431189FA4CBAEC9E7DD5441E010124F087@orsmsx402.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Intel PRO/1000 NIC
Thread-Index: AcODsJ+gPGW+vDpHThKB16xzVtwvSQACRkng
From: "Feldman, Scott" <scott.feldman@intel.com>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 25 Sep 2003 23:05:09.0340 (UTC) FILETIME=[777D61C0:01C383B9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Are there any patches available for 2.4 without all the 
> compat things ?

2.4.23-pre5 has a pretty resent version.  Jeff just accepted 5.2.16
patches into his net-drivers-2.4 tree, but I haven't looked if these
have been pushed out.

These in 2.4.23-prex don't have the kcompat stuff.

-scott
