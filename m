Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751082AbVJFPKr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751082AbVJFPKr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 11:10:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751081AbVJFPKr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 11:10:47 -0400
Received: from rrcs-67-78-243-58.se.biz.rr.com ([67.78.243.58]:56464 "EHLO
	mail.concannon.net") by vger.kernel.org with ESMTP id S1751078AbVJFPKr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 11:10:47 -0400
Message-ID: <43453E7F.5030801@concannon.net>
Date: Thu, 06 Oct 2005 11:10:55 -0400
From: Michael Concannon <mike@concannon.net>
User-Agent: Mozilla Thunderbird 1.0.6-1.4.1.centos4 (X11/20050721)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chase Venters <chase.venters@clientec.com>
CC: Luke Kenneth Casson Leighton <lkcl@lkcl.net>,
       Marc Perkel <marc@perkel.com>, linux-kernel@vger.kernel.org
Subject: Re: what's next for the linux kernel?
References: <20051002204703.GG6290@lkcl.net> <200510041840.55820.chase.venters@clientec.com> <20051005102650.GO10538@lkcl.net> <200510060005.09121.chase.venters@clientec.com>
In-Reply-To: <200510060005.09121.chase.venters@clientec.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chase Venters wrote:

>On Wednesday 05 October 2005 05:26 am, Luke Kenneth Casson Leighton wrote:
>  
>
>>>Now I certainly wouldn't advocate a Windows-style registry,
>>>because I think it's full of obvious problems.
>>>      
>>>
>> such as? :)
>>    
>>
>
>If such a thing were even going to be attempted on UNIX, it would have to be 
>so different than the NT approach that it would stop looking like a registry 
>altogether.
>  
>
All good points, but perhaps the most compelling to me is that virtually 
every successful windows virus out there does its real damage by 
modifying the registry to replace key actions, associate bad actions 
with good ones and just generally screw the system up...

One could argue that this is no different than a hapless victim running 
as root getting his/her /etc/* files modified but:
a. the decentralization there makes it easy to distinguish those files 
which have been touched and how to fix them
b. they are all ASCII
c. they are not modified often, most almost never after initial system 
config
d. you don't have every app that runs mod'ing those files... (in fact 
few are even allowed to)
e. what the !@#$ would I want to cache my most recently visited URLs in 
the same place I decide where the entry hooks to my video driver live?

Anyone suggesting that Linux or Unix in general should inherit this, 
what I consider, most fatal flaw of all the flaws of windows should be 
dealt with harshly...

Sorry, could not resist responding - I cannot count the hours I have 
spent searching and clearing registry entries in family and friend's 
computers after they downloaded the latest cool virus...

/mike



