Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268674AbUJMOwj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268674AbUJMOwj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 10:52:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267823AbUJMOwi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 10:52:38 -0400
Received: from mail4.utc.com ([192.249.46.193]:62673 "EHLO mail4.utc.com")
	by vger.kernel.org with ESMTP id S267792AbUJMOwg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 10:52:36 -0400
Message-ID: <416D4128.3030903@cybsft.com>
Date: Wed, 13 Oct 2004 09:52:24 -0500
From: "K.R. Foley" <kr@cybsft.com>
Organization: Cybersoft Solutions, Inc.
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>,
       Wen-chien Jesse Sung <jesse@cola.voip.idv.tw>,
       Mark_H_Johnson@Raytheon.com
Subject: Re: [patch] VP-2.6.9-rc4-mm1-T9
References: <OF29AF5CB7.227D041F-ON86256F2A.0062D210@raytheon.com> <20041011215909.GA20686@elte.hu> <20041012091501.GA18562@elte.hu> <20041012123318.GA2102@elte.hu> <20041012195424.GA3961@elte.hu> <20041013061518.GA1083@elte.hu>
In-Reply-To: <20041013061518.GA1083@elte.hu>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> i've uploaded the -T9 VP patch:
> 
>   http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc4-mm1-T9
> 
OK. This one actually boots all the way into X and even shuts down 
cleanly (no errors either way). Still no keyboard, which is why I had to 
shut it down. :) Does this indicate that the keyboard is actually being 
detected or no?

Oct 13 09:29:59 swdev14 kernel: requesting new irq thread for IRQ1...
Oct 13 09:29:59 swdev14 kernel: IRQ#1 thread started up.
Oct 13 09:29:59 swdev14 kernel: input: AT Translated Set 2 keyboard on 
isa0060/serio0

We're getting there. This is with ipv6 disabled, btw.

kr
