Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267509AbUHWVKW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267509AbUHWVKW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 17:10:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266548AbUHWVHU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 17:07:20 -0400
Received: from mail3.utc.com ([192.249.46.192]:7091 "EHLO mail3.utc.com")
	by vger.kernel.org with ESMTP id S266806AbUHWVEM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 17:04:12 -0400
Message-ID: <412A5BA6.2060608@cybsft.com>
Date: Mon, 23 Aug 2004 16:03:34 -0500
From: "K.R. Foley" <kr@cybsft.com>
Organization: Cybersoft Solutions, Inc.
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040803)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org, Florian Schmidt <mista.tapas@gmx.net>,
       Lee Revell <rlrevell@joe-job.com>
Subject: Re: [patch] voluntary-preempt-2.6.8.1-P7
References: <1092628493.810.3.camel@krustophenia.net> <20040816040515.GA13665@elte.hu> <1092654819.5057.18.camel@localhost> <20040816113131.GA30527@elte.hu> <20040816120933.GA4211@elte.hu> <1092716644.876.1.camel@krustophenia.net> <20040817080512.GA1649@elte.hu> <20040819073247.GA1798@elte.hu> <20040820133031.GA13105@elte.hu> <20040820195540.GA31798@elte.hu> <20040821140501.GA4189@elte.hu>
In-Reply-To: <20040821140501.GA4189@elte.hu>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> i've uploaded the -P7 patch:
> 
>   http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.8.1-P7
> 

Here are a couple more traces in the ~200 - ~300 usec range:

http://www.cybsft.com/testresults/2.6.8.1-P7/2.6.8.1-P7-4.txt

http://www.cybsft.com/testresults/2.6.8.1-P7/2.6.8.1-P7-10.txt

Also, can someone tell me why I often see traces in the 4 ms range with 
  3 - 4 ms being reported by a single routine?

kr


