Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271324AbTHHNFZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 09:05:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271329AbTHHNFZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 09:05:25 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:37041 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S271324AbTHHNFU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 09:05:20 -0400
Message-ID: <3F33A00B.2090502@namesys.com>
Date: Fri, 08 Aug 2003 17:05:15 +0400
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030210
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tomas Szepe <szepe@pinerecords.com>
CC: Oleg Drokin <green@namesys.com>, Ivan Gyurdiev <ivg2@cornell.edu>,
       Andreas Dilger <adilger@clusterfs.com>, linux-kernel@vger.kernel.org
Subject: Re: reiserfs4
References: <200308070305.51868.vlad@lazarenko.net> <20030806230220.I7752@schatzie.adilger.int> <3F31DFCC.6040504@cornell.edu> <20030807072751.GA23912@namesys.com> <20030807132111.GB7094@louise.pinerecords.com>
In-Reply-To: <20030807132111.GB7094@louise.pinerecords.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tomas Szepe wrote:

>>[green@namesys.com]
>>
>>    
>>
>>>>Why do people ever want a "converter"?
>>>>        
>>>>
>>>That's been discussed before.
>>>Because people don't have the resources (hard disk space, tape drives, 
>>>money)  to backup their data, and might still be interested in testing a 
>>>new filesystem. They might be willing to take a risk with the new fs 
>>>and converter. Amazing as it may sound, people do that. I am such a 
>>>tester, and I'd find a converter to be a useful tool. But since the 
>>>previous discussion on the subject concluded it'd be really hard to 
>>>impossible to write one, I guess I'll have to settle for new hard drive(s).
>>>      
>>>
>>This is no longer true.
>>There is sort of "universal" fs convertor for linux that can convert almost
>>any fs to almost any other fs.
>>The only requirement seems to be that both fs types should have read/write support in Linux.
>>http://tzukanov.narod.ru/convertfs/
>>    
>>
>
>I'm afraid I cannot recommend using this tool.
>
>A test conversion from reiserfs to ext3 (inside a vmware machine)
>screwed up the data real horrorshow: directory structure seems
>ok but file contents are apparently shifted.
>
>  
>
Are you sure that vmware does not affect the result?

-- 
Hans


