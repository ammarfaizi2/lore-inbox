Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262425AbUEQVst@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262425AbUEQVst (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 17:48:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262422AbUEQVst
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 17:48:49 -0400
Received: from mail.tmr.com ([216.238.38.203]:56580 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S262425AbUEQVss (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 17:48:48 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: Re: Linux Kernel 2.6 SMP+HT + 1 Intel P4 HT CPU
Date: Mon, 17 May 2004 17:51:03 -0400
Organization: TMR Associates, Inc
Message-ID: <c8bbpm$lab$1@gatekeeper.tmr.com>
References: <20040514133947.GB21039@outpost.ds9a.nl> <Pine.LNX.4.58.0405141106460.24191@p500>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: gatekeeper.tmr.com 1084830326 21835 192.168.12.100 (17 May 2004 21:45:26 GMT)
X-Complaints-To: abuse@tmr.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
In-Reply-To: <Pine.LNX.4.58.0405141106460.24191@p500>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Justin Piszcz wrote:
> So essentially, if one does not enable SMP in Linux, they are not taking
> advantage of hyper threading!?
> 
> On Fri, 14 May 2004, bert hubert wrote:
> 
> 
>>On Fri, May 14, 2004 at 08:49:39AM -0400, Justin Piszcz wrote:
>>
>>>Why would you use SMP on an HT cpu?
>>>Is this reccomended?
>>
>>Yes, it acts like one.

Not any performance gain, at least. However, people in comp.sys.intel 
report that the CPU runs cooler with HT enabled, even if you don't use 
it. Since this was a number of reports, you may want to check it on your 
own if you care.

No, I don't know why.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
