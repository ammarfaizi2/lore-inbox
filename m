Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267488AbUHXLRn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267488AbUHXLRn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 07:17:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267486AbUHXLRm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 07:17:42 -0400
Received: from relay.pair.com ([209.68.1.20]:6419 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id S267482AbUHXLRc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 07:17:32 -0400
X-pair-Authenticated: 66.190.51.173
Message-ID: <412B23C9.8080507@cybsft.com>
Date: Tue, 24 Aug 2004 06:17:29 -0500
From: "K.R. Foley" <kr@cybsft.com>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040803)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Lee Revell <rlrevell@joe-job.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] voluntary-preempt-2.6.8.1-P8
References: <20040816120933.GA4211@elte.hu> <1092716644.876.1.camel@krustophenia.net> <20040817080512.GA1649@elte.hu> <20040819073247.GA1798@elte.hu> <20040820133031.GA13105@elte.hu> <20040820195540.GA31798@elte.hu> <20040821140501.GA4189@elte.hu> <20040823210151.GA10949@elte.hu> <1093312154.862.17.camel@krustophenia.net> <412ABC8B.5080608@cybsft.com> <20040824060946.GA31052@elte.hu>
In-Reply-To: <20040824060946.GA31052@elte.hu>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * K.R. Foley <kr@cybsft.com> wrote:
> 
> 
>>http://www.cybsft.com/testresults/2.6.8.1-P8/latency_trace3.txt
> 
> 
> this trace shows a TX processing latency of 45 frames - please try
> 'ifconfig eth0 txqueuelen 8', does it help?
> 
> 	Ingo
> 
There's no difference that jumps out at me. Here are a couple more with
txqueuelen=8

http://www.cybsft.com/testresults/2.6.8.1-P8/latency_trace7.txt
http://www.cybsft.com/testresults/2.6.8.1-P8/latency_trace8.txt

kr

