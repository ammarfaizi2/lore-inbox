Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133022AbREBMpQ>; Wed, 2 May 2001 08:45:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133012AbREBMpG>; Wed, 2 May 2001 08:45:06 -0400
Received: from www.teaparty.net ([216.235.253.180]:33811 "EHLO
	www.teaparty.net") by vger.kernel.org with ESMTP id <S132934AbREBMpC>;
	Wed, 2 May 2001 08:45:02 -0400
Date: Wed, 2 May 2001 13:44:54 +0100 (BST)
From: Vivek Dasmohapatra <vivek@etla.org>
To: Russell King <rmk@arm.linux.org.uk>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux NAT questions- (kernel upgrade??)
In-Reply-To: <20010502133823.A5778@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.10.10105021343030.19069-100000@www.teaparty.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 May 2001, Russell King wrote:

> On Wed, May 02, 2001 at 08:22:54AM -0400, Feng Xian wrote:
> > i think iptables is a new feature in kernel 2.4.x(and you have to build
> > it in the kernel or as module). you can use ipchains if
> > you are running kernel with lower version, 2.2.something.
> 
> I think you'll find that 2.4 is compatible with ipchains, as long as
> you load the relevent module/configure the kernel right.

Which doesn't appear to be the problem, as the guy seems to be running 2.2
or at least 2.4 w/o iptables.

-- 
"Aren't you ashamed of yourself?"
"No, I have people to do that for me."

