Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267578AbUHVQSM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267578AbUHVQSM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 12:18:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267701AbUHVQSM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 12:18:12 -0400
Received: from relay.pair.com ([209.68.1.20]:64785 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id S267578AbUHVQSL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 12:18:11 -0400
X-pair-Authenticated: 66.190.51.173
Message-ID: <4128C742.6090402@cybsft.com>
Date: Sun, 22 Aug 2004 11:18:10 -0500
From: "K.R. Foley" <kr@cybsft.com>
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

Is this one for real, or another false positive? A ~4119 usec latency in
the scheduler?

http://www.cybsft.com/testresults/2.6.8.1-P7/2.6.8.1-P7-5.txt

kr
