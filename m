Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267208AbTBDQVM>; Tue, 4 Feb 2003 11:21:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267287AbTBDQVM>; Tue, 4 Feb 2003 11:21:12 -0500
Received: from franka.aracnet.com ([216.99.193.44]:5836 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S267208AbTBDQVM>; Tue, 4 Feb 2003 11:21:12 -0500
Date: Tue, 04 Feb 2003 08:27:28 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Adrian Bunk <bunk@fs.tum.de>
cc: linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
Subject: Re: [Lse-tech] Re: gcc 2.95 vs 3.21 performance
Message-ID: <177230000.1044376046@[10.10.2.4]>
In-Reply-To: <173250000.1044373915@[10.10.2.4]>
References: <Pine.LNX.3.95.1030203182417.7651A-100000@chaos.analogic.com>
 <200302040656.h146uJs10531@Port.imtp.ilyichevsk.odessa.ua>
 <162450000.1044342810@[10.10.2.4]> <20030204122536.GV6915@fs.tum.de>
 <173250000.1044373915@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> Comparing Intel's compiler vs GCC on Linux would be more interesting.
>>> Anyone got a copy and some time to burn?
>> 
>> There are already people who have done this, e.g.
>> 
>>   http://www.coyotegulch.com/reviews/intel_comp/intel_gcc_bench2.html
>> 
>> compares g++ and Intel's C++ compiler with C++ code.
> 
> C would be infinitely more interesting ;-)

Speaking of which, has anyone ever compiled the ia32 Linux kernel with the
Intel compiler? I thought I saw some patches floating around to make it
compile the ia64 kernel .... that'd be an interesting test case ... might
give us some ideas about what could be tweaked in GCC (or code rejiggled in
the kernel).

M.

