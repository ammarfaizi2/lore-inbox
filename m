Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286774AbRLVNcq>; Sat, 22 Dec 2001 08:32:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286775AbRLVNcg>; Sat, 22 Dec 2001 08:32:36 -0500
Received: from mta1n.bluewin.ch ([195.186.1.210]:64242 "EHLO mta1n.bluewin.ch")
	by vger.kernel.org with ESMTP id <S286774AbRLVNcS>;
	Sat, 22 Dec 2001 08:32:18 -0500
Message-ID: <3C2343B90005C3A1@mta1n.bluewin.ch> (added by postmaster@bluewin.ch)
From: "Per Jessen" <per@computer.org>
To: "Linux KernelList" <linux-kernel@vger.kernel.org>
Date: Sat, 22 Dec 2001 14:30:12 +0100
Reply-To: "Per Jessen" <per@computer.org>
X-Mailer: PMMail 98 Professional (2.01.1600) For Windows 95 (4.0.1212)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: Re: Configure.help editorial policy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Dec 2001 15:33:52 -0600, Thomas Dodd wrote:
>
>Benjamin LaHaise wrote:
>
>> GiB is not a useful standard because NOBODY USES IT.  When it's in 
>> common use, then consider applying it to the kernel, but please, 
>> not before then.
>
>
>What better place to start "common use" then the kernel source.
>Let's lead the way, not wait around to follow others.
>

And in fact, people are using it. Like I said earlier, I used to work
in StorageTek R&D, and we started using it. In fact the hardware people
started first, so the displays on our VSM arrays (Terabyte sized RAID
arrays) would use the kB = 1000byte whereas our reports would use 
kB=1024byte. Big confusion. 
AFAIR, the decision made to go with the IEC standard was primarily
because it was a standard. 


regards,
Per Jessen, Zurich

regards,
Per Jessen, Zurich
http://www.enidan.com - home of the J1 serial console.

Windows 2001: "I'm sorry Dave ...  I'm afraid I can't do that."


