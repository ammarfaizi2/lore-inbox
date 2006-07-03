Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932164AbWGCWw4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932164AbWGCWw4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 18:52:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932172AbWGCWw4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 18:52:56 -0400
Received: from mail.tmr.com ([64.65.253.246]:4519 "EHLO gaimboi.tmr.com")
	by vger.kernel.org with ESMTP id S932164AbWGCWwz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 18:52:55 -0400
Message-ID: <44A9A196.1010602@tmr.com>
Date: Mon, 03 Jul 2006 19:00:38 -0400
From: Bill Davidsen <davidsen@tmr.com>
Organization: TMR Associates Inc, Schenectady NY
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Valdis.Kletnieks@vt.edu
CC: linux-kernel@vger.kernel.org
Subject: Re: ext4 features
References: <20060701163301.GB24570@cip.informatik.uni-erlangen.de> <20060701170729.GB8763@irc.pl> <20060701174716.GC24570@cip.informatik.uni-erlangen.de> <20060701181702.GC8763@irc.pl> <20060703202219.GA9707@aitel.hist.no>            <44A98D5A.5030508@tmr.com> <200607032150.k63LoM4H027543@turing-police.cc.vt.edu>
In-Reply-To: <200607032150.k63LoM4H027543@turing-police.cc.vt.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu wrote:

>On Mon, 03 Jul 2006 17:34:18 EDT, Bill Davidsen said:
>  
>
>>I think he is talking about another problem. RAID addresses detectable
>>failures at the hardware level. I believe that he wants validation after
>>the data is returned (without error) from the device. While in most
>>cases if what you wrote and what you read don't match it's memory,
>>improving the chances of catching the error is useful, given that
>>non-server often lacks ECC on memory, or people buy cheaper non-parity
>>memory.
>>    
>>
>
>There's other issues as well.  Why do people run 'tripwire' on boxes that
>have RAID on them?
>  
>
What has RAID got to do with detecting hacking?

-- 
bill davidsen <davidsen@tmr.com>
  CTO TMR Associates, Inc
  Doing interesting things with small computers since 1979

