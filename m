Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271669AbRIJU2a>; Mon, 10 Sep 2001 16:28:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271672AbRIJU2L>; Mon, 10 Sep 2001 16:28:11 -0400
Received: from mta5.rcsntx.swbell.net ([151.164.30.29]:45988 "EHLO
	rcsntx.swbell.net") by vger.kernel.org with ESMTP
	id <S271669AbRIJU2B>; Mon, 10 Sep 2001 16:28:01 -0400
Date: Mon, 10 Sep 2001 15:24:54 -0500
From: edebill@swbell.net
Subject: Re: nfs client oops, all 2.4 kernels
In-Reply-To: <"from olivier"@molteni.net>
To: Olivier Molteni <olivier@molteni.net>
Cc: linux-kernel@vger.kernel.org
Message-id: <20010910152454.A31438@mail.swbell.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010910100202.A14106@www.creditminders.com>
 <20010910173420.11d2fa71.skraw@ithnet.com> <3B9D19EA.7F3AE823@molteni.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 10, 2001 at 09:52:10PM +0200, Olivier Molteni wrote:
> 
> Hi, see my post and related answers [ Oops NFS Locking in 2.4.x] I have the same
> Problem.
> Returning on *thisfl_p == NULL don't fix the trouble... Kernel no more Oops, but
> process stay in wait state on IO (D).
> 
> See the answers from Trond Myklebust, I think he is right...

That's what I get for not reading LKML over the weekend :-)

Sounds like he has a handle on the problem - I'll gladly test patches
if one of you comes up with a (proposed) fix.


Erik
