Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261744AbVADSEY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261744AbVADSEY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 13:04:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261751AbVADSEX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 13:04:23 -0500
Received: from fmr20.intel.com ([134.134.136.19]:16068 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S261744AbVADSEL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 13:04:11 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [openib-general] Re: [PATCH][v5][0/24] Latest IB patch queue
Date: Tue, 4 Jan 2005 09:58:59 -0800
Message-ID: <1AC79F16F5C5284499BB9591B33D6F00032CA55B@orsmsx408>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [openib-general] Re: [PATCH][v5][0/24] Latest IB patch queue
Thread-Index: AcTtRtA8sfH+7rkCRfybU0u6Of9gBQFPznFQ
From: "Woodruff, Robert J" <robert.j.woodruff@intel.com>
To: "Roland Dreier" <roland@topspin.com>,
       "Karen Shaeffer" <shaeffer@neuralscape.com>
Cc: <netdev@oss.sgi.com>, <linux-kernel@vger.kernel.org>,
       <openib-general@openib.org>
X-OriginalArrivalTime: 04 Jan 2005 17:59:01.0344 (UTC) FILETIME=[1238DE00:01C4F287]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 

    Karen> I am interested in Infiniband with x86_64 Opterons.

Roland>OK, the current code should work well for you -- x86_64 is
probably
Roland>the most-tested architecture.

I have tested on X86_64 EM64T systems. I have a 4 node cluster that I
ran
some MPI tests on top of IpoIB over the holidays and it ran without 
any problems. I know that others have also tested on x86_64 Opteron, 
so it should work fine for that arch. 

woody
