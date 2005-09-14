Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965049AbVINWJV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965049AbVINWJV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 18:09:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965061AbVINWJU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 18:09:20 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:48811 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S965049AbVINWJT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 18:09:19 -0400
Message-ID: <43289F8C.4050004@us.ibm.com>
Date: Wed, 14 Sep 2005 15:09:16 -0700
From: Darren Hart <dvhltc@us.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050727)
X-Accept-Language: en-us, en
MIME-Version: 1.0
CC: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>, dwalker@mvista.com,
       George Anzinger <george@mvista.com>
Subject: Re: 2.6.13-rt6, ktimer subsystem
References: <20050913100040.GA13103@elte.hu> <43284816.8010501@dvhart.com>
In-Reply-To: <43284816.8010501@dvhart.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Darren Hart wrote:

 > Ingo Molnar wrote:
 >  > i have released the 2.6.13-rt6 tree, which can be downloaded from the
 >  > usual place:
 >  >
 >  >   http://redhat.com/~mingo/realtime-preempt/
 >
 > I haven't been able to get 2.6.13-rt6 to compile on a 16 way x440 
(SUMMIT) with gcc-2.95.  Is there a known minimum compiler version?  The 
same config builds fine on a P3 8 way with gcc-3.3.5.


Update: I was able to build the same config on the SUMMIT box with 
gcc-3.3.5, so the compiler version does seem to be the issue.


-- 
Darren Hart
IBM Linux Technology Center
Linux Kernel Team
Phone: 503 578 3185
   T/L: 775 3185
