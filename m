Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964845AbWEBOfv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964845AbWEBOfv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 10:35:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964846AbWEBOfv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 10:35:51 -0400
Received: from stinky.trash.net ([213.144.137.162]:39835 "EHLO
	stinky.trash.net") by vger.kernel.org with ESMTP id S964845AbWEBOfu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 10:35:50 -0400
Message-ID: <44576E45.4070909@trash.net>
Date: Tue, 02 May 2006 16:35:49 +0200
From: Patrick McHardy <kaber@trash.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       coreteam@netfilter.org, "David S. Miller" <davem@davemloft.net>,
       Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [netfilter-core] Re: [lockup] 2.6.17-rc3: netfilter/sctp: lockup
 in	sctp_new(), do_basic_checks()
References: <20060502113454.GA28601@elte.hu> <20060502134053.GA30917@elte.hu> <4457648C.6020100@trash.net> <20060502140102.GA31743@elte.hu> <4457654A.9040200@trash.net> <20060502141621.GA32284@elte.hu> <44576CD5.60603@trash.net> <20060502143814.GA3789@elte.hu>
In-Reply-To: <20060502143814.GA3789@elte.hu>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Patrick McHardy <kaber@trash.net> wrote:
> 
>>How about this patch (based on your patch, but typos fixed and also 
>>covers nf_conntrack)?
> 
> 
> sure, fine with me!

OK, thanks. I'll pass it on to Dave soon.
