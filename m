Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132015AbRCVNks>; Thu, 22 Mar 2001 08:40:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132016AbRCVNkh>; Thu, 22 Mar 2001 08:40:37 -0500
Received: from chaos.analogic.com ([204.178.40.224]:40832 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S132015AbRCVNkW>; Thu, 22 Mar 2001 08:40:22 -0500
Date: Thu, 22 Mar 2001 08:39:06 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: nbecker@fred.net
cc: linux-kernel@vger.kernel.org
Subject: Re: regression testing
In-Reply-To: <x88zoeeeyh8.fsf@adglinux1.hns.com>
Message-ID: <Pine.LNX.3.95.1010322083448.20107C-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 22 Mar 2001 nbecker@fred.net wrote:

> Hi.  I was wondering if there has been any discussion of kernel
> regression testing.  Wouldn't it be great if we didn't have to depend
> on human testers to verify every change didn't break something?
> 
> OK, I'll admit I haven't given this a lot of thought.  What I'm
> wondering is whether the user-mode linux could help here (allow a way
> to simulate controlled activity).
> -

Regression testing __is__ what happens when 10,000 testers independently
try to break the software!

Canned so-called "regression-test" schemes will fail to test at least
90 percent of the code paths, while attempting to "test" 100 percent
of the code!


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


