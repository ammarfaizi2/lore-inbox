Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129740AbRCARPE>; Thu, 1 Mar 2001 12:15:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129742AbRCAROz>; Thu, 1 Mar 2001 12:14:55 -0500
Received: from smtp.primusdsl.net ([209.225.164.93]:18191 "EHLO
	mailhost.digitalselect.net") by vger.kernel.org with ESMTP
	id <S129740AbRCAROg>; Thu, 1 Mar 2001 12:14:36 -0500
Date: Thu, 1 Mar 2001 12:15:54 -0500
From: James Lewis Nance <jlnance@intrex.net>
To: Hans Reiser <reiser@namesys.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: What is 2.4 Linux networking performance like compared to BSD?
Message-ID: <20010301121554.A861@bessie.dyndns.org>
In-Reply-To: <3A9D891C.434E3AA7@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <3A9D891C.434E3AA7@namesys.com>; from reiser@namesys.com on Thu, Mar 01, 2001 at 02:26:20AM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 01, 2001 at 02:26:20AM +0300, Hans Reiser wrote:
> I have a client that wants to implement a webcache, but is very leery of
> implementing it on Linux rather than BSD.
> 
> They know that iMimic's polymix performance on Linux 2.2.* is half what it
> is on BSD.  Has the Linux 2.4 networking code caught up to BSD?
> 
> Can I tell them not to worry about the Linux networking code strangling their
> webcache product's performance, or not?

Hi Hans,
    I dont have an answer for you, but it would be nice to know the answer.
Would it be difficult to measure this?  It should not be difficult to make
a machine dual boot Linux and BSD, and then we can measure the differences.
If there is a significant performance difference either way then we can
try and investigate it to see why.

Thanks,

Jim
