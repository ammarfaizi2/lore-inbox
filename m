Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264799AbTBEUTL>; Wed, 5 Feb 2003 15:19:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264815AbTBEUTL>; Wed, 5 Feb 2003 15:19:11 -0500
Received: from jive.SoftHome.net ([66.54.152.27]:10195 "HELO jive.SoftHome.net")
	by vger.kernel.org with SMTP id <S264799AbTBEUTK>;
	Wed, 5 Feb 2003 15:19:10 -0500
References: <200302052021.h15KLrXv000881@darkstar.example.net>
In-Reply-To: <200302052021.h15KLrXv000881@darkstar.example.net> 
From: b_adlakha@softhome.net
To: John Bradford <john@grabjohn.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: gcc 2.95 vs 3.21 performance
Date: Wed, 05 Feb 2003 13:28:46 -0700
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [210.214.82.239]
Message-ID: <courier.3E4173FE.00002CEE@softhome.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Bradford writes: 

>> No really, I downloaded tcc yesterday, compiled a few things with it and it 
>> is REALLY fast...and as I wrote yesterday, its small enough so people might 
>> say:  
>> 
>> A: "I can't compile linux, what is wrong?"
>> B: "Here, compile it with the compiler attached to this message"  
>> 
>> Sounds like fun doesn't it? I mean, tcc is a working C compiler (thats 
>> supposed to be a great thing), and its only 170 kb gzipped tar! 
> 
> I haven't actually had chance to test tcc yet, but I'll try to
> tomorrow.  How close is it to being able to compile the kernel? 
> 
> John.
Far away, it doesn't even compile the ncurses based menuconfig...I think we 
need to hack (seriously) either tcc or linux... Since tcc is so small it 
would be easier to make it run it (bit) more like gcc, than modifying the 
whole kernel... 

