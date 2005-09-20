Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964778AbVITQ05@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964778AbVITQ05 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 12:26:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964782AbVITQ04
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 12:26:56 -0400
Received: from bayc1-pasmtp03.bayc1.hotmail.com ([65.54.191.163]:49028 "EHLO
	BAYC1-PASMTP03.bayc1.hotmail.com") by vger.kernel.org with ESMTP
	id S964778AbVITQ04 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 12:26:56 -0400
Message-ID: <BAYC1-PASMTP033EBAB483DBE4397549B2AE950@cez.ice>
X-Originating-IP: [67.71.125.52]
X-Originating-Email: [seanlkml@sympatico.ca]
Message-ID: <36267.10.10.10.28.1127233614.squirrel@linux1>
In-Reply-To: <43303650.5030202@sfhq.hn.org>
References: <Pine.LNX.4.58.0509192003410.2553@g5.osdl.org>   
    <200509201005.49294.gene.heskett@verizon.net>   
    <20050920141008.GA493@flint.arm.linux.org.uk>   
    <200509201025.36998.gene.heskett@verizon.net>   
    <56402.10.10.10.28.1127229646.squirrel@linux1>   
    <20050920153231.GA2958@localhost.localdomain>
    <BAYC1-PASMTP030BBDF3F9B2552DA9CF26AE950@cez.ice>
    <43303650.5030202@sfhq.hn.org>
Date: Tue, 20 Sep 2005 12:26:54 -0400 (EDT)
Subject: Re: Arrr! Linux v2.6.14-rc2
From: "Sean" <seanlkml@sympatico.ca>
To: "Jan Dittmer" <jdi@sfhq.hn.org>
Cc: "Alexander Nyberg" <alexn@telia.com>,
       "Gene Heskett" <gene.heskett@verizon.net>, linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.4-2
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
X-OriginalArrivalTime: 20 Sep 2005 16:26:28.0442 (UTC) FILETIME=[0D6C83A0:01C5BE00]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, September 20, 2005 12:18 pm, Jan Dittmer said:
> Sean wrote:
>> On Tue, September 20, 2005 11:32 am, Alexander Nyberg said:
>>
>>>ketchup <version>
>>
>> "git pull" is actually simpler in that you don't need to specify a
>> version.  And it will keep you current with HEAD even between official
>> releases.
>
> $ ketchup 2.6-git
>
> and you've the plus of very well defined checkpoints.

Huh?  Have you ever used git?  Not only do you get very well defined
checkpoints you can instantiate a tree down to any specific commit.  And
you get the plus of a complete detailed changelog etc.. "git log".  
Really, ketchup doesn't come close to git.

Sean

