Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261281AbSJNNK1>; Mon, 14 Oct 2002 09:10:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261301AbSJNNK1>; Mon, 14 Oct 2002 09:10:27 -0400
Received: from blackbird.intercode.com.au ([203.32.101.10]:20750 "EHLO
	blackbird.intercode.com.au") by vger.kernel.org with ESMTP
	id <S261281AbSJNNK0>; Mon, 14 Oct 2002 09:10:26 -0400
Date: Mon, 14 Oct 2002 23:16:05 +1000 (EST)
From: James Morris <jmorris@intercode.com.au>
To: Bernd Jendrissek <berndj@prism.co.za>
cc: linux-kernel@vger.kernel.org
Subject: Re: What is "recvmsg bug: copied 870A11AD seq 0"?  (2.2.19)
In-Reply-To: <20021014115341.A22933@prism.co.za>
Message-ID: <Mutt.LNX.4.44.0210142313470.21746-100000@blackbird.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Oct 2002, Bernd Jendrissek wrote:

> Hello all
> 
> What does it mean if the last 9 items in dmesg from a 2.2.19 kernel say
> "recvmsg bug: copied 870A11AD seq 0"?  Same sequence number each time.
> 
> A kernel (known) bug?  Some bogus TCP segments?

It's been reported a few times, but I'm not sure if it's been resolved.

Can you please post the version of the compiler which compiled the kernel, 
what kind of hardware you're running on, and if it's a stock kernel or has 
vendor/other patches applied.


- James
-- 
James Morris
<jmorris@intercode.com.au>


