Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263211AbSKEADg>; Mon, 4 Nov 2002 19:03:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263228AbSKEADg>; Mon, 4 Nov 2002 19:03:36 -0500
Received: from 64-60-75-69.cust.telepacific.net ([64.60.75.69]:2569 "EHLO
	racerx.ixiacom.com") by vger.kernel.org with ESMTP
	id <S263211AbSKEADf>; Mon, 4 Nov 2002 19:03:35 -0500
Message-ID: <3DC70C0C.4040004@ixiacom.com>
Date: Mon, 04 Nov 2002 16:08:44 -0800
From: Dan Kegel <dkegel@ixiacom.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020615 Debian/1.0.0-3
MIME-Version: 1.0
To: Geoff Gustafson <geoff@linux.co.intel.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       sglass@us.ibm.com
Subject: Re: [ANNOUNCE] Open POSIX Test Suite
References: <3DC702E1.1050306@ixiacom.com> <00fd01c2845e$eb407ee0$7fd40a0a@amr.corp.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Geoff Gustafson wrote:
>>You are about to duplicate http://ltp.sf.net
> 
> 
> My understanding is that LTP is focused on current mainline kernel testing,
> while this project's initial concern is areas that are not currently in Linux
> like POSIX message queues, semaphores, and full support for POSIX threads. I see
> this as being used to evaluate different implementations that are being
> considered for inclusion in the kernel, glibc, etc.
> 
> This project is concerned with the POSIX APIs regardless of where they are
> implemented (kernel, glibc, etc.). Thus it can focus on POSIX, independent of
> implementation. This project will be more concerned with traceability back to
> the POSIX specification, and completeness of coverage, than I would expect from
> LTP.
> 
> That said, there is some overlap, and an exchange of test cases between the
> projects may be very useful.
> 
> I've copied Stephanie from LTP to get her reaction.

Geoff,
thanks for the reply.  I have a feeling that LTP would be overjoyed
to have you contribute to the LTP and make it a more accurate Posix
compliance test.  The areas that Linux does not currently cover --
message queues, semaphores, etc -- *should* be in the LTP, regardless
of whether Linux currently implements them.  Linux's 'expected results'
on these tests would be 'fail' at the moment.  That's not a problem.

The LTP would also greatly benefit from better tracability and coverage.

I urge you to consider ways in which you could work within the
framework of the LTP to meet both your goals and the LTP's goals.
They may be more in synch than you originally thought!
- Dan


