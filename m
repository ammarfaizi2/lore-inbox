Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261318AbTCGDXM>; Thu, 6 Mar 2003 22:23:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261335AbTCGDXM>; Thu, 6 Mar 2003 22:23:12 -0500
Received: from franka.aracnet.com ([216.99.193.44]:39111 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S261318AbTCGDXL>; Thu, 6 Mar 2003 22:23:11 -0500
Date: Thu, 06 Mar 2003 19:33:33 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Steven Cole <elenstev@mesatop.com>, Val Henson <val@nmt.edu>
cc: Dave Jones <davej@codemonkey.org.uk>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Those ruddy punctuation fixes
Message-ID: <300890000.1047008011@[10.10.2.4]>
In-Reply-To: <1047005054.4114.99.camel@spc1.mesatop.com>
References: <20030305111015.B8883@flint.arm.linux.org.uk><20030305122008.GA4280@suse.de> <1046920285.3786.68.camel@spc1.mesatop.com> <20030307010422.GI26725@boardwalk> <1047005054.4114.99.camel@spc1.mesatop.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Wait, this sounds like a conversation with the Mafia:
>> 
>> "Pay us protection money."
>> "Why do we need to pay you for protection?"
>> "So we can protect you from criminals like ourselves."
> 
> That's a ridiculous comparison and it weakens your argument.  Leaving a

Reductio ad absurdum is often enlightening.

> potential problem in place rather than fixing it as I did would be the
> passive-aggressive approach, not the other way around.

But that's not exactly what you're doing - you're replacing one 
(very small) problem with another (very real) problem, the breakage 
of people's patches. Fixing up patches because of spelling
errors is a total waste of developer's time.

>> I'd rather solve this problem by making standalone spelling fixes and
>> other cosmetic changes taboo.  Cosmetic changes combined with actual
>> useful code changes are fine with me.  If you're risking breaking the
>> build, there should be some benefit that justifies the risk.
> 
> Breaking the build is a low probability (many hundreds of fixes and one 
> build break AFAIK) and low consequence failure (a build fix of that
> nature is obvious and quickly and easily done).

Breaking the build is indeed a low probability (assuming you compile
test your tree). Breaking other people's patches is a high probablility.

M.
