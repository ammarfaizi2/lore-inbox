Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262474AbUKDW6w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262474AbUKDW6w (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 17:58:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262473AbUKDW4m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 17:56:42 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:3977 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262474AbUKDWhn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 17:37:43 -0500
Date: Thu, 04 Nov 2004 14:36:10 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Adam Heath <doogie@debian.org>, Linus Torvalds <torvalds@osdl.org>
cc: Chris Wedgwood <cw@f00f.org>, Christoph Hellwig <hch@infradead.org>,
       Timothy Miller <miller@techsource.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: support of older compilers
Message-ID: <308030000.1099607770@flay>
In-Reply-To: <Pine.LNX.4.58.0411041546160.1229@gradall.private.brainfood.com>
References: <41894779.10706@techsource.com> <20041103211353.GA24084@infradead.org><Pine.LNX.4.58.0411031706350.1229@gradall.private.brainfood.com><20041103233029.GA16982@taniwha.stupidest.org><Pine.LNX.4.58.0411041050040.1229@gradall.private.brainfood.com><Pine.LNX.4.58.0411041133210.2187@ppc970.osdl.org> <Pine.LNX.4.58.0411041546160.1229@gradall.private.brainfood.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > I didn't deny the speed difference of older and newer compilers.
>> > 
>> > But why is this an issue when compiling a kernel?  How often do you compile
>> > your kernel?
>> 
>> First off, for some people that is literally where _most_ of the CPU
>> cycles go.
> 
> So find a fast machine.  As I have already said, you don't need to compile a
> kernel for a slow machine/arch *on* a slow machine/arch.
> 
>> Second, it's not just that the compilers are slower. Historically, new gcc
>> versions are:
>>  - slower
> 
> Again, that's a straw man.
> 
>>  - generate worse code
>>  - buggier
> 
> I don't doubt these are issues.  That's not what I am discussing.

Ummm. you asked why people don't use newer compilers, you were told exactly
why. How is that not what you're discussing?

Not breaking older compilers takes very little effort in practice. Why the
hell would you want to break compilation with then?

M.

