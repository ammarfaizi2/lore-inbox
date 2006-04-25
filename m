Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751367AbWDYTzE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751367AbWDYTzE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 15:55:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751414AbWDYTzE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 15:55:04 -0400
Received: from rwcrmhc13.comcast.net ([204.127.192.83]:64246 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S1751367AbWDYTzC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 15:55:02 -0400
Message-ID: <444E7E94.3080409@acm.org>
Date: Tue, 25 Apr 2006 14:55:00 -0500
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla Thunderbird 1.0.6-7.5.20060mdk (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Gross, Mark" <mark.gross@intel.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, bluesmoke-devel@lists.sourceforge.net,
       LKML <linux-kernel@vger.kernel.org>,
       "Carbonari, Steven" <steven.carbonari@intel.com>,
       "Ong, Soo Keong" <soo.keong.ong@intel.com>,
       "Wang, Zhenyu Z" <zhenyu.z.wang@intel.com>
Subject: Re: Problems with EDAC coexisting with BIOS
References: <5389061B65D50446B1783B97DFDB392DA53ECC@orsmsx411.amr.corp.intel.com>
In-Reply-To: <5389061B65D50446B1783B97DFDB392DA53ECC@orsmsx411.amr.corp.intel.com>
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shouldn't you provide a way (kernel command line) to override this check
if the function can be safely unhidden?

-Corey

Gross, Mark wrote:

>
>
>Patch to work around this problem is attached.
>
>Signed-off-by: Mark Gross
>
>--mgross
>  
>

