Return-Path: <linux-kernel-owner+w=401wt.eu-S1754652AbWLRVvb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754652AbWLRVvb (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 16:51:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754651AbWLRVvb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 16:51:31 -0500
Received: from mail.tmr.com ([64.65.253.246]:55655 "EHLO gaimboi.tmr.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754650AbWLRVva (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 16:51:30 -0500
Message-ID: <45870EB9.5080800@tmr.com>
Date: Mon, 18 Dec 2006 16:57:13 -0500
From: Bill Davidsen <davidsen@tmr.com>
Organization: TMR Associates Inc, Schenectady NY
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.8) Gecko/20061105 SeaMonkey/1.0.6
MIME-Version: 1.0
To: Alan <alan@lxorguk.ukuu.org.uk>
CC: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.20-rc1
References: <Pine.LNX.4.64.0612131744290.5718@woody.osdl.org>	<4582D246.3010701@tmr.com> <20061215172852.2d4dcaa6@localhost.localdomain>
In-Reply-To: <20061215172852.2d4dcaa6@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan wrote:
> On Fri, 15 Dec 2006 11:50:14 -0500
> Bill Davidsen <davidsen@tmr.com> wrote:
>   
>> Did I miss an alternate method of handling ftape devices, or are these 
>> old beasts now unsupported? I occasionally have to be able to handle 
>> that media, since the industrial device using ftape for control updates 
>> cost more than a small house.
>>     
>
> Do you have hardware and the time to at least test cleanups ?
>
>   
>> I can obviously keep an old slow machine to do the job, but I'd like to 
>> know if I need to.
>>     
>
> The assumption was that since in 2.6 it was so ancient and unloved that
> nobody had even seen an ftape device this century. If it is still being
> used and you can test cleanups then the removal should be reverted

As much as I have in the past supported keeping useful features in the 
kernel, this one can go from 2.6 as far as I'm concerned. I would hate 
to see anyone spend any time maintaining something which is so little 
used. I can easily move the hardware to a 2.4 machine, or something 
running an early 2.6.

I think "ancient and unloved" is an apt description.

-- 
bill davidsen <davidsen@tmr.com>
  CTO TMR Associates, Inc
  Doing interesting things with small computers since 1979

