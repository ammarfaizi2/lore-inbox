Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314475AbSDWWtC>; Tue, 23 Apr 2002 18:49:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314478AbSDWWtC>; Tue, 23 Apr 2002 18:49:02 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:38155 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S314475AbSDWWtB>; Tue, 23 Apr 2002 18:49:01 -0400
Date: Tue, 23 Apr 2002 18:46:10 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: blesson paul <blessonpaul@msn.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: /dev/zero
In-Reply-To: <F10qwZ2cFXvmBUCsQrU0000e2b7@hotmail.com>
Message-ID: <Pine.LNX.3.96.1020423184416.31248F-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Apr 2002, blesson paul wrote:

> 		I need some more information about /dev/zero. I need to replace the device 
> driver of /dev/zero(I do not know whether I can name the program controlling 
> the /dev/zero as device driver). How to do the job. If I cannot replace the 
> device driver of /dev/zero, how to create a new charecter device and load my 
> device driver.

  I have to ask, WHY? Is this because you want to return a value other
than zero, to to improve the performance of /dev/zero, or just to write a
driver (/dev/one could be used ;-).

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

