Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265329AbUAPIsT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 03:48:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265337AbUAPIsT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 03:48:19 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:24555 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S265329AbUAPIsP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 03:48:15 -0500
Message-ID: <4007A54A.3030005@namesys.com>
Date: Fri, 16 Jan 2004 11:48:10 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Vladimir Saveliev <vs@namesys.com>
CC: Jan De Luyck <lkml@kcore.org>, linux-kernel@vger.kernel.org,
       reiserfs-list@namesys.com
Subject: Re: [2.4.18]: Reiserfs: vs-2120: add_save_link: insert_item	returned
 -28
References: <200401091622.41352.lkml@kcore.org> <1074241063.2251.41.camel@tribesman.namesys.com>
In-Reply-To: <1074241063.2251.41.camel@tribesman.namesys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vladimir Saveliev wrote:

>Hello
>
>On Fri, 2004-01-09 at 18:22, Jan De Luyck wrote:
>  
>
>>Hello list,
>>
>>Today I discovered I could no longer create files on one of my boxes, which 
>>still runs 2.4.18 (box is too far away to upgrade right now). It gives me 
>>'disk full' messages.
>>
>>The following message is all over my logs since January 3:
>>
>>vs-2120: add_save_link: insert_item returned -28
>>
>>    
>>
>
>This is just a warning. You should be able to free some disk space by
>removing some files.
>
>
>
>  
>
>>I can't seem to find much on this issue, is this a bug in reiserfs (which is 
>>fixed in a later version)? Is something wrong with the fs itself?
>>
>>Thanks for answers.
>>
>>[I'm not subscribed @ reiserfs-list, so please cc me with answers from that 
>>list]
>>
>>Jan
>>    
>>
>
>
>
>  
>
why do we generate this warning?  It should be fixed, yes?

-- 
Hans


