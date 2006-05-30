Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932376AbWE3VDp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932376AbWE3VDp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 17:03:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932394AbWE3VDp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 17:03:45 -0400
Received: from sj-iport-5.cisco.com ([171.68.10.87]:6439 "EHLO
	sj-iport-5.cisco.com") by vger.kernel.org with ESMTP
	id S932376AbWE3VDo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 17:03:44 -0400
X-IronPort-AV: i="4.05,190,1146466800"; 
   d="scan'208"; a="285521237:sNHT118268750"
To: Arjan van de Ven <arjan@infradead.org>
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch, -rc5-mm1] lock validator: fix RT_HASH_LOCK_SZ
X-Message-Flag: Warning: May contain useful information
References: <20060530022925.8a67b613.akpm@osdl.org>
	<adaac8z70yc.fsf@cisco.com> <20060530202654.GA25720@elte.hu>
	<ada1wub6y6b.fsf@cisco.com> <20060530204901.GA27645@elte.hu>
	<adawtc35iws.fsf@cisco.com>
	<1149022880.3636.116.camel@laptopd505.fenrus.org>
From: Roland Dreier <rdreier@cisco.com>
Date: Tue, 30 May 2006 14:03:38 -0700
In-Reply-To: <1149022880.3636.116.camel@laptopd505.fenrus.org> (Arjan van de Ven's message of "Tue, 30 May 2006 23:01:20 +0200")
Message-ID: <adaslmr5iol.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 30 May 2006 21:03:39.0789 (UTC) FILETIME=[8693ABD0:01C6842C]
Authentication-Results: sj-dkim-6.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Arjan> do you have KALLSYMS_ALL enabled? This looks like a thing
    Arjan> we already fixed as well... but it also looks a bit odd ..

Nope, sorry.  Will rebuild and resend.

 - R.
