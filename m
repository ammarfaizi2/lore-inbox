Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264479AbRFTREP>; Wed, 20 Jun 2001 13:04:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264480AbRFTREF>; Wed, 20 Jun 2001 13:04:05 -0400
Received: from tmhoyle.gotadsl.co.uk ([195.149.46.162]:46098 "HELO
	mail.cvsnt.org") by vger.kernel.org with SMTP id <S264479AbRFTRDx>;
	Wed, 20 Jun 2001 13:03:53 -0400
Message-ID: <3B30D776.5090902@magenta-netlogic.com>
Date: Wed, 20 Jun 2001 18:03:50 +0100
From: Tony Hoyle <tmh@magenta-netlogic.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.5-ac13 i686; en-US; rv:0.9.1) Gecko/20010618
X-Accept-Language: en-us
MIME-Version: 1.0
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Russell Leighton <russell.leighton@247media.com>,
        linux-kernel@vger.kernel.org, Ben Greear <greearb@candelatech.com>
Subject: Re: [OT] Threads, inelegance, and Java
In-Reply-To: <XFMail.20010620093214.davidel@xmailserver.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide Libenzi wrote:


> 1) HW is cheaper than software engineers time


Compared to E1000s???  You must be talking about some *really* expensive 
engineers!


> 2) to find Java developers is easier than to find C developers


Depends on where you are in the world.  It's certainly not true here 
(everyone knows C/C++...  Haven't had a java developer apply for a job 
in months).

 
> 3) the ETA of the same project developed in Java is shorter than the same
>         project done in C


Depends on the developers.  Good developers can churn out the same 
project to roughly the same timescale in any language (except possibly 
assembly).

Java is useful if you need the cross platform bit & the target users 
aren't technically savvy enough to recompile.  For an in-house app where 
you control the hardware you'd be better off using a C/C++/RAD & doing 
it native.

Tony


(Just came back from a .NET conference...  MS are currently rewriting 
all their apps in bytecode... whoopee...  They're even porting *games* 
to run on it.  I can see it now 'MS Flight Simulator .NET' (Requires 
quad Pentium 4 1.6Ghz minimum) :-o )

Tony

-- 
"Two weeks before due date, the programmers work 22 hour days
  cobbling an application from... (apparently) one programmer
  bashing his face into the keyboard." -- Dilbert

tony@hoyle.geek 
	http://www.tony.hoyle.geek
tmh@nothing-on.tv 
http://www.nothing-on.tv

