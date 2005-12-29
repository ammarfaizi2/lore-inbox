Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965050AbVL2ILX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965050AbVL2ILX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 03:11:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932592AbVL2ILX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 03:11:23 -0500
Received: from smtp102.plus.mail.mud.yahoo.com ([68.142.206.235]:7542 "HELO
	smtp102.plus.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932591AbVL2ILW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 03:11:22 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=XiKgW5SuMFRprKu9ZK17k+XDhX6Xgvb1wea6AAnT0hct9ZlkIzlwsiUox3fKGvPmH5nLtTAPRvKaU7cbqWsudWhrWjhW4NrzbAMVYrB7eblu+ST9r9qcaM2cxSiDz1LQiDcqDjCintBSYF/hDtyfFxNXET4VSHZqjnul4GjdhEw=  ;
Message-ID: <43B39A23.8000302@yahoo.com.au>
Date: Thu, 29 Dec 2005 19:11:15 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Peter Williams <pwil3058@bigpond.net.au>
CC: Paolo Ornati <ornati@fastwebnet.it>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Con Kolivas <kernel@kolivas.org>, Ingo Molnar <mingo@elte.hu>
Subject: Re: [SCHED] Totally WRONG prority calculation with specific test-case
 (since 2.6.10-bk12)
References: <20051227190918.65c2abac@localhost>	<20051227224846.6edcff88@localhost>	<43B1D551.5050503@bigpond.net.au> <20051228112058.2c0c1137@localhost> <43B29540.1030904@bigpond.net.au> <43B3545D.3010508@yahoo.com.au> <43B35986.90408@bigpond.net.au>
In-Reply-To: <43B35986.90408@bigpond.net.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Williams wrote:
> Nick Piggin wrote:

>> It isn't a dead scheduler any more than any of the other out of tree
>> schedulers are (which isn't saying much, unfortunately).
> 
> 
> Ingosched, staircase and my SPA schedulers are all evolving slowly.
>  Are there any out there that I don't have in PlugSched that you think 
> should be?
> 

Not that I know of...

>>
>> I've probably got a small number of cleanups and microoptimisations
>> relative to what you have (I can't remember exactly what you sucked up)
>> ... but other than that there hasn't been much development work done for
>> some time because there is not much wrong with it.
>>
> 
> I was starting to think that you'd lost interest in this which is why I 
> said it was more or less dead.  Sorry.
> 

No worries. I haven't lost interest so much as people seem to be fairly
happy with the current scheduler and least aren't busting my door down
for updates to nicksched ;)

I'll do a resynch for 2.6.15 though.

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
