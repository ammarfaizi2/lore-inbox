Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287874AbSAVGyy>; Tue, 22 Jan 2002 01:54:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288114AbSAVGyn>; Tue, 22 Jan 2002 01:54:43 -0500
Received: from zero.tech9.net ([209.61.188.187]:1029 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S287874AbSAVGyb>;
	Tue, 22 Jan 2002 01:54:31 -0500
Subject: Re: 2.4.18pre4aa1
From: Robert Love <rml@tech9.net>
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020122074806.A1547@athlon.random>
In-Reply-To: <20020122074806.A1547@athlon.random>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1 
Date: 22 Jan 2002 01:58:58 -0500
Message-Id: <1011682739.17096.563.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-01-22 at 01:48, Andrea Arcangeli wrote:

> Only in 2.4.18pre4aa1/: 00_icmp-offset-1
> 
> 	Remote security fix from Andi (see bugtraq).

Are we sure this works?  I thought I saw someone (IRC perhaps?) who had
weird anomalies with this fix (although it does certainly fix the hole).

> Only in 2.4.18pre2aa2: 10_vm-22
> Only in 2.4.18pre4aa1/: 10_vm-23
> 
> 	Minor changes (try to always do some relevant work during the
> 	refiling).

When will we see this in 2.4 stock? ;-)

I know you have said you are busy, but it would great to get the bits
pushed to Marcelo in reasonable documented chunks so he can merge
them...

Also, these should be pushed to Linus, too.  Same VM in 2.5, after all.

	Robert Love

