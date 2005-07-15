Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263295AbVGOMl2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263295AbVGOMl2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 08:41:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263289AbVGOMlX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 08:41:23 -0400
Received: from mail.tmr.com ([64.65.253.246]:30394 "EHLO gaimboi.tmr.com")
	by vger.kernel.org with ESMTP id S263277AbVGOMkH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 08:40:07 -0400
Message-ID: <42D7B017.4060300@tmr.com>
Date: Fri, 15 Jul 2005 08:46:15 -0400
From: Bill Davidsen <davidsen@tmr.com>
Organization: TMR Associates Inc, Schenectady NY
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050511
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
CC: Linus Torvalds <torvalds@osdl.org>, Lee Revell <rlrevell@joe-job.com>,
       Vojtech Pavlik <vojtech@suse.cz>,
       Arjan van de Ven <arjan@infradead.org>,
       dean gaudet <dean-list-linux-kernel@arctic.org>,
       Chris Wedgwood <cw@f00f.org>, Andrew Morton <akpm@osdl.org>,
       "Brown, Len" <len.brown@intel.com>, dtor_core@ameritech.net,
       david.lang@digitalinsight.com, kernel@kolivas.org,
       linux-kernel@vger.kernel.org, mbligh@mbligh.org, diegocg@gmail.com,
       azarah@nosferatu.za.org, christoph@lameter.com
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
References: <d120d50005071312322b5d4bff@mail.gmail.com>	 <1121286258.4435.98.camel@mindpipe> <20050713134857.354e697c.akpm@osdl.org>	 <20050713211650.GA12127@taniwha.stupidest.org>	 <Pine.LNX.4.63.0507131639130.13193@twinlark.arctic.org>	 <20050714005106.GA16085@taniwha.stupidest.org>	 <Pine.LNX.4.63.0507131810430.13193@twinlark.arctic.org>	 <1121304825.4435.126.camel@mindpipe>	 <Pine.LNX.4.58.0507131847000.17536@g5.osdl.org>	 <1121326938.3967.12.camel@laptopd505.fenrus.org>	 <20050714121340.GA1072@ucw.cz>	 <Pine.LNX.4.58.0507140933150.19183@g5.osdl.org>	 <1121383050.4535.73.camel@mindpipe>	 <Pine.LNX.4.58.0507141623490.19183@g5.osdl.org>	 <1121384499.4535.82.camel@mindpipe>	 <Pine.LNX.4.58.0507141648070.19183@g5.osdl.org> <1121394653.19939.775.camel@cmn37.stanford.edu>
In-Reply-To: <1121394653.19939.775.camel@cmn37.stanford.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fernando Lopez-Lezcano wrote:

>On Thu, 2005-07-14 at 16:49, Linus Torvalds wrote:
>  
>
>>On Thu, 14 Jul 2005, Lee Revell wrote:
>>    
>>
>>>And I'm incredibly frustrated by this insistence on hard data when it's
>>>completely obvious to anyone who knows the first thing about MIDI that
>>>HZ=250 will fail in situations where HZ=1000 succeeds.
>>>      
>>>
>>Ok, guys. How many people have this MIDI thing? How many of you can't be 
>>bothered to set the default to suit your usage?
>>
>>    
>>
>>>It's straight from the MIDI spec.  Your argument is pretty close to "the
>>>MIDI spec is wrong, no one can hear the difference between 1ms and 4ms".
>>>      
>>>
>>No.
>>
>>YOUR argument is "nobody else matters, only I do".
>>
>>MY argument is that this is a case of give and take. 
>>    
>>
>
>Take from "few" multimedia users, give to "many" laptop users. Where
>"few" and "many" are not very well defined quantities, but obviously
>"many" > "few" :-) 
>
Of course that assumes that these are not the same users, which clearly 
isn't true in all cases.

-- 
bill davidsen <davidsen@tmr.com>
  CTO TMR Associates, Inc
  Doing interesting things with small computers since 1979

