Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261524AbUCJBxJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 20:53:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261920AbUCJBxI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 20:53:08 -0500
Received: from 1-2-2-1a.has.sth.bostream.se ([82.182.130.86]:42450 "EHLO
	K-7.stesmi.com") by vger.kernel.org with ESMTP id S261524AbUCJBxG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 20:53:06 -0500
Message-ID: <404E74EF.1010204@stesmi.com>
Date: Wed, 10 Mar 2004 02:52:47 +0100
From: Stefan Smietanowski <stesmi@stesmi.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7a) Gecko/20040219
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Norberto Bensa <norberto+linux-kernel@bensa.ath.cx>
CC: Norihiko Mukouyama <norihiko_m@jp.fujitsu.com>,
       Ingo at Pyrillion <ingo@pyrillion.org>, linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.6.3 patch for Intel Compiler 8.0
References: <FLEBKJHLJPMMOPBNJGELCEMMCNAA.norihiko_m@jp.fujitsu.com> <200403092156.57423.norberto+linux-kernel@bensa.ath.cx>
In-Reply-To: <200403092156.57423.norberto+linux-kernel@bensa.ath.cx>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Norberto Bensa wrote:

> Norihiko Mukouyama wrote:
> 
>>Hi All!!
>>
>>
>>>Results: 33% of the lmbench procs faster on icc, 66% faster on gcc.
>>
>>If it is ture using icc 66% faster than gcc., It is wonderful.
>>Could you show us detail data to  lmbench results.
> 
> 
> I saw it the other way around: gcc is faster 66% of the time. Or did I read 
> wrong?

1/3 of the things are faster with icc. 2/3 of the things are faster
with gcc. Performance numbers not given.

// Stefan
