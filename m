Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261536AbVACRnJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261536AbVACRnJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 12:43:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261535AbVACRlR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 12:41:17 -0500
Received: from smtpout.mac.com ([17.250.248.86]:65021 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S261766AbVACRkR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 12:40:17 -0500
In-Reply-To: <20050103153758.GY29332@holomorphy.com>
References: <1697129508.20050102210332@dns.toxicfilms.tv> <20050102203615.GL29332@holomorphy.com> <20050102212427.GG2818@pclin040.win.tue.nl> <20050102214211.GM29332@holomorphy.com> <20050102221534.GG4183@stusta.de> <Pine.LNX.4.61.0501031019110.25392@chimarrao.boston.redhat.com> <20050103152953.GE2980@stusta.de> <20050103153758.GY29332@holomorphy.com>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <6D2C0E07-5DAE-11D9-9FD3-000D9352858E@mac.com>
Content-Transfer-Encoding: 7bit
Cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org,
       Rik van Riel <riel@redhat.com>,
       Maciej Soltysiak <solt2@dns.toxicfilms.tv>,
       Andries Brouwer <aebr@win.tue.nl>,
       William Lee Irwin III <wli@debian.org>
From: Felipe Alfaro Solana <lkml@mac.com>
Subject: Re: starting with 2.7
Date: Mon, 3 Jan 2005 18:39:32 +0100
To: William Lee Irwin III <wli@holomorphy.com>
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3 Jan 2005, at 16:37, William Lee Irwin III wrote:

> On Mon, Jan 03, 2005 at 10:20:40AM -0500, Rik van Riel wrote:
>>> 2.2 before 2.2.20 also had this kind of problem, as did
>>> the 2.4 kernel before 2.4.20 or thereabouts.
>>> I'm pretty sure 2.6 is actually doing better than the
>>> early 2.0, 2.2 and 2.4 kernels...
>
> On Mon, Jan 03, 2005 at 04:29:53PM +0100, Adrian Bunk wrote:
>> My personal impression was that even the 2.6.0-test kernels were much
>> better than the 2.4.0-test kernels.
>> But 2.6.20 will most likely still have the stability of the early
>> 2.6 kernels instead of a greatly increased stability as observed in
>> 2.2.20 and 2.4.20 .
>
> This is speculation; there is no reason not to expect the process to
> converge to as great of stability or greater stability than the
> 2.4-style process. I specuate that it will in fact do precisely that.

I would like to comment in that the issue is not exclusively targeted 
to stability, but the ability to keep up with kernel development. For 
example, it was pretty common for older versions of VMWare and NVidia 
driver to break up whenever a new kernel version was released.

I think it's a PITA for developers to rework some of the closed-source 
code to adopt the new changes in the Linux kernel.

