Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267278AbUHXRuc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267278AbUHXRuc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 13:50:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267575AbUHXRub
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 13:50:31 -0400
Received: from mail4.utc.com ([192.249.46.193]:43655 "EHLO mail4.utc.com")
	by vger.kernel.org with ESMTP id S267278AbUHXRua (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 13:50:30 -0400
Message-ID: <412B7FCB.10208@cybsft.com>
Date: Tue, 24 Aug 2004 12:50:03 -0500
From: "K.R. Foley" <kr@cybsft.com>
Organization: Cybersoft Solutions, Inc.
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040803)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] voluntary-preempt-2.6.8.1-P8
References: <20040816113131.GA30527@elte.hu> <20040816120933.GA4211@elte.hu>	 <1092716644.876.1.camel@krustophenia.net> <20040817080512.GA1649@elte.hu>	 <20040819073247.GA1798@elte.hu> <20040820133031.GA13105@elte.hu>	 <20040820195540.GA31798@elte.hu> <20040821140501.GA4189@elte.hu>	 <20040823210151.GA10949@elte.hu> <1093312154.862.17.camel@krustophenia.net>	 <20040824054128.GA29027@elte.hu> <1093326406.817.7.camel@krustophenia.net>	 <412B4736.4040706@cybsft.com> <1093365170.817.27.camel@krustophenia.net>
In-Reply-To: <1093365170.817.27.camel@krustophenia.net>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:
<snip>
> 
> I am able to generate a 1012 usec latency by flood pinging the broadcast
> address.  These are pretty pathological cases, but if we are going for
> bounded latency it seems like they should be addressed.
> 
> Lee
> 

I agree, if that is possible. Whether it's possible in all cases is not 
something I am really qualified to answer.

kr


