Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318076AbSHKIoh>; Sun, 11 Aug 2002 04:44:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318154AbSHKIoh>; Sun, 11 Aug 2002 04:44:37 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:19721 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S318076AbSHKIog>; Sun, 11 Aug 2002 04:44:36 -0400
Message-ID: <3D562498.9020901@namesys.com>
Date: Sun, 11 Aug 2002 12:47:20 +0400
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tom Vier <tmv@comcast.net>
CC: JFS-Discussion <jfs-discussion@www-124.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Testing of filesystems
References: <20020730094902.GA257@prester.freenet.de> <20020811025018.GE17886@zero>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Vier wrote:

>On Tue, Jul 30, 2002 at 11:49:02AM +0200, Axel Siebenwirth wrote:
>  
>
>>I wonder what a good way is to stress test my JFS filesystem. Is there a tool
>>    
>>
><snip>
>
>fsx.c came up a while ago on l-k. it's an old (but still very useful) fs
>stressor(sp) from neXT. i have a copy davej modded for linux. if you can't
>find it, i can send it to you. i haven't been brave enough to run it myself,
>on my alpha's reiserfs. 8) it found some hard to find bugs in ext2 that were
>lurking for years (iirc).
>
>  
>
It found bugs in reiserfs and we fixed them.:)

-- 
Hans



