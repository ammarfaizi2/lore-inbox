Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262952AbVDHU0u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262952AbVDHU0u (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 16:26:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262950AbVDHU0u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 16:26:50 -0400
Received: from relay00.pair.com ([209.68.1.20]:1543 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id S262949AbVDHUZz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 16:25:55 -0400
X-pair-Authenticated: 24.241.238.70
Message-ID: <4256E8DB.1000104@cybsft.com>
Date: Fri, 08 Apr 2005 15:26:03 -0500
From: "K.R. Foley" <kr@cybsft.com>
Organization: Cybersoft Solutions, Inc.
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: Rui Nuno Capela <rncbc@rncbc.org>, Steven Rostedt <rostedt@goodmis.org>,
       Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc2-V0.7.44-00
References: <20050325145908.GA7146@elte.hu> <20050331085541.GA21306@elte.hu>	 <20050401104724.GA31971@elte.hu> <20050405071911.GA23653@elte.hu>	 <46802.192.168.1.5.1112727980.squirrel@www.rncbc.org>	 <1112729762.5147.62.camel@localhost.localdomain>	 <39754.192.168.1.5.1112973759.squirrel@www.rncbc.org>	 <1112980542.10271.4.camel@mindpipe>  <4256E671.4040303@cybsft.com> <1112991421.11000.39.camel@mindpipe>
In-Reply-To: <1112991421.11000.39.camel@mindpipe>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:
> On Fri, 2005-04-08 at 15:15 -0500, K.R. Foley wrote:
> 
>>Lee Revell wrote:
>>
>>>On Fri, 2005-04-08 at 16:22 +0100, Rui Nuno Capela wrote:
>>>
>>>
>>>>>Our first victim!! :-)
>>>>>
>>>>
>>>>No kidding!?
>>>>
>>>
>>>
>>>V0.7.44-02 does not even compile for me.  It appears to be full of merge
>>>errors.
>>>
>>
>>I must be in the twilight zone over here. V0.7.44-02 runs fine on my UP 
>>system, my older SMP system (although I have to compile in my SCSI 
>>drivers, but that has nothing to do with this patch) and my faster P4/HT 
>>SMP system at the office.
> 
> 
> Meh, I'll try again, maybe it's some weird NFS problem.
> 
> Lee
> 

Hmm. Maybe. I should probably mention that I am doing an FC3 install via 
NFS from my older SMP system right now while also building V0.7.44-03.

-- 
    kr
