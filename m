Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280814AbRLVRQL>; Sat, 22 Dec 2001 12:16:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281458AbRLVRP4>; Sat, 22 Dec 2001 12:15:56 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:24337 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S280814AbRLVRPq>; Sat, 22 Dec 2001 12:15:46 -0500
Date: Sat, 22 Dec 2001 17:15:38 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.5: PCI setup reorg (alpha, arm, parisc)
Message-ID: <20011222171538.A21533@flint.arm.linux.org.uk>
In-Reply-To: <20011222190548.A2097@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011222190548.A2097@jurassic.park.msu.ru>; from ink@jurassic.park.msu.ru on Sat, Dec 22, 2001 at 07:05:48PM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 22, 2001 at 07:05:48PM +0300, Ivan Kokshaysky wrote:
> Only generic and alpha changes here - parisc folks should be almost in
> sync, and required ARM changes look more or less straightforward.

What's happening about prefetchable memory regions?  You said in your
previous emails on this subject that it would be covered in your up
and coming patch (which I believe this is), but I haven't seen any
mention of it, nor do I see any sign of it in the code.

Thanks.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

