Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267197AbTAPStS>; Thu, 16 Jan 2003 13:49:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267199AbTAPStR>; Thu, 16 Jan 2003 13:49:17 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:63383 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S267197AbTAPSsW>; Thu, 16 Jan 2003 13:48:22 -0500
Date: Thu, 16 Jan 2003 10:48:05 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Robert Love <rml@tech9.net>, Erich Focht <efocht@ess.nec.de>
cc: Michael Hohnbaum <hohnbaum@us.ibm.com>,
       Andrew Theurer <habanero@us.ibm.com>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>,
       Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 2.5.58] new NUMA scheduler: fix
Message-ID: <7620000.1042742885@flay>
In-Reply-To: <1042740441.826.55.camel@phantasy>
References: <52570000.1042156448@flay> <200301151610.43204.efocht@ess.nec.de> <23340000.1042697129@titus> <200301161747.14863.efocht@ess.nec.de> <1042740441.826.55.camel@phantasy>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, 2003-01-16 at 11:47, Erich Focht wrote:
> 
>> Fine. This form is also nearer to the codingstyle rule: "functions
>> should do only one thing" (I'm reading those more carefully now ;-)
> 
> Good ;)
> 
> This is looking good.  Thanks hch for going over it with your fine tooth
> comb.
> 
> Erich and Martin, what more needs to be done prior to inclusion?  Do you
> still want an exec balancer in place?

Yup, that's in patch 2 already. I just pushed it ... will see what
happens.

M.

