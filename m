Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277743AbRJLQYr>; Fri, 12 Oct 2001 12:24:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277746AbRJLQYj>; Fri, 12 Oct 2001 12:24:39 -0400
Received: from mail.spylog.com ([194.67.35.220]:12684 "HELO mail.spylog.com")
	by vger.kernel.org with SMTP id <S277743AbRJLQY1>;
	Fri, 12 Oct 2001 12:24:27 -0400
Date: Fri, 12 Oct 2001 20:20:48 +0400
From: "Oleg A. Yurlov" <kris@spylog.com>
X-Mailer: The Bat! (v1.53d)
Reply-To: "Oleg A. Yurlov" <kris@spylog.com>
Organization: SpyLOG Ltd.
X-Priority: 3 (Normal)
Message-ID: <38618742584.20011012202048@spylog.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org, mantel@suse.de
Subject: Re[2]: 2.4.7 from updates for SuSE 7.2 - crash.
In-Reply-To: <20011012054558.W714@athlon.random>
In-Reply-To: <159543829765.20011011233216@spylog.com>
 <20011012054558.W714@athlon.random>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


        Hi, Andrea and all,

Friday, October 12, 2001, 7:45:58 AM, you wrote:

>>         Hi, Hubert, Andrea and all,
>> 
>>         My server crashed again...
>> 
>>         Symptom: procfs die, processes unaccessible...
AA> could be the down_read recursion. Many bugs are been fixed after 2.4.7.

        I  know... but 2.4.7.SuSE declared as kernel for production use :-) Some
people in our organization have wanted to install this kernel... |-)

AA> Can you try if you can reproduce with Hubert's latest kernel based on
AA> 2.4.12aa1? thanks!

        Now  I  install  this  kernel  on  one SMP server and will install on UP
server in the near future. Uptime about 1 day under heavy load, all Ok :-)

AA> Andrea

--
Oleg A. Yurlov aka Kris Werewolf, SysAdmin      OAY100-RIPN
mailto:kris@spylog.com                          +7 095 332-03-88

