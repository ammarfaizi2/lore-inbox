Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262319AbUKDS4R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262319AbUKDS4R (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 13:56:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262326AbUKDS4Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 13:56:16 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:15045 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S262319AbUKDSzq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 13:55:46 -0500
Message-ID: <418A7AFC.6040007@us.ibm.com>
Date: Thu, 04 Nov 2004 10:54:52 -0800
From: Ian Romanick <idr@us.ibm.com>
User-Agent: Mozilla Thunderbird 0.8 (Windows/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adam Heath <doogie@debian.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: support of older compilers
References: <41894779.10706@techsource.com> <20041103211353.GA24084@infradead.org> <Pine.LNX.4.58.0411031706350.1229@gradall.private.brainfood.com> <20041103233029.GA16982@taniwha.stupidest.org>            <Pine.LNX.4.58.0411041050040.1229@gradall.private.brainfood.com> <200411041704.iA4H4sdZ014948@turing-police.cc.vt.edu> <Pine.LNX.4.58.0411041214590.1229@gradall.private.brainfood.com>
In-Reply-To: <Pine.LNX.4.58.0411041214590.1229@gradall.private.brainfood.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam Heath wrote:
> On Thu, 4 Nov 2004,  wrote:
>>On Thu, 04 Nov 2004 10:50:38 CST, Adam Heath said:
>>
>>>I didn't deny the speed difference of older and newer compilers.
>>>
>>>But why is this an issue when compiling a kernel?  How often do you compile
>>>your kernel?
>>
>>If you're working on older hardware (note the number of people on this
>>list still using 500mz Pentium3 and similar), and a kernel developer, the
>>difference between 2 hours to build a kernel and 4 hours to build a
>>kernel matters quite a bit.
> 
> Use faster hardware to compile a kernel.  Cross-compiling is easy for kernels.
> 
> Plus, at least on i386/debian, kernel-package makes it easy.

And if that 500MHz Pentium3 *IS* they fastest hardware they have? 
Should they just go carjack someone to fund a new system to make you 
happy? ;)  Not everyone has a corporation like IBM or Redhat to fund 
their hardware needs.  A lot of people that make real, valuable 
contributions to lk are on a shoestring budget.
