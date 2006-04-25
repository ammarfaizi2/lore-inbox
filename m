Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932262AbWDYUWR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932262AbWDYUWR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 16:22:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751464AbWDYUWR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 16:22:17 -0400
Received: from mga03.intel.com ([143.182.124.21]:28934 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1751445AbWDYUWQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 16:22:16 -0400
X-IronPort-AV: i="4.04,154,1144047600"; 
   d="scan'208"; a="27693984:sNHT46051740"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Problems with EDAC coexisting with BIOS
Date: Tue, 25 Apr 2006 13:22:13 -0700
Message-ID: <5389061B65D50446B1783B97DFDB392DA9757C@orsmsx411.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Problems with EDAC coexisting with BIOS
Thread-Index: AcZooinUFmuobZodQRKda3DhCVAlUQAA5iJw
From: "Gross, Mark" <mark.gross@intel.com>
To: "Corey Minyard" <minyard@acm.org>
Cc: "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       <bluesmoke-devel@lists.sourceforge.net>,
       "LKML" <linux-kernel@vger.kernel.org>,
       "Carbonari, Steven" <steven.carbonari@intel.com>,
       "Ong, Soo Keong" <soo.keong.ong@intel.com>,
       "Wang, Zhenyu Z" <zhenyu.z.wang@intel.com>
X-OriginalArrivalTime: 25 Apr 2006 20:22:13.0897 (UTC) FILETIME=[F0696790:01C668A5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Something like a force-unhide parameter?

That makes sense, I'll take a stab at it now.

--mgross

>-----Original Message-----
>From: Corey Minyard [mailto:minyard@acm.org]
>Sent: Tuesday, April 25, 2006 12:55 PM
>To: Gross, Mark
>Cc: Alan Cox; bluesmoke-devel@lists.sourceforge.net; LKML; Carbonari,
>Steven; Ong, Soo Keong; Wang, Zhenyu Z
>Subject: Re: Problems with EDAC coexisting with BIOS
>
>Shouldn't you provide a way (kernel command line) to override this
check
>if the function can be safely unhidden?
>
>-Corey
>
>Gross, Mark wrote:
>
>>
>>
>>Patch to work around this problem is attached.
>>
>>Signed-off-by: Mark Gross
>>
>>--mgross
>>
>>
