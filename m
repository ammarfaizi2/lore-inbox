Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265389AbSJaWLP>; Thu, 31 Oct 2002 17:11:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265413AbSJaWJy>; Thu, 31 Oct 2002 17:09:54 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:50190 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S265398AbSJaWI6>; Thu, 31 Oct 2002 17:08:58 -0500
Message-ID: <3DC1AB38.1040107@namesys.com>
Date: Fri, 01 Nov 2002 01:14:16 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2b) Gecko/20021016
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David C. Hansen" <haveblue@us.ibm.com>
CC: David Lang <david.lang@digitalinsight.com>,
       "Robert L. Harris" <Robert.L.Harris@rdlg.net>,
       Linux-Kernel <linux-kernel@vger.kernel.org>,
       Oleg Drokin <green@namesys.com>
Subject: Re: Reiser vs EXT3
References: <Pine.LNX.4.44.0210311248030.25405-100000@dlang.diginsite.com> 	<3DC1A5D5.8000901@namesys.com> <1036102211.4272.276.camel@nighthawk>
In-Reply-To: <Pine.LNX.4.44.0210311248030.25405-100000@dlang.diginsite.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David C. Hansen wrote:

>On Thu, 2002-10-31 at 13:51, Hans Reiser wrote:
>  
>
>>If you want to talk about 2.6 then you should talk about reiser4 not 
>>reiserfs v3, and reiser4 is 7.6 times the write performance of ext3 for 
>>30 copies of the linux kernel source code using modern IDE drives and 
>>modern processors on a dual-CPU box, so I don't think any amount of 
>>improved scalability will make ext3 competitive with reiser4 for 
>>performance usages.  
>>
>>We haven't had anyone test performance using RAID yet for reiser4, that 
>>could be fun.
>>    
>>
>
>I have a 14-drive hardware RAID array on an 8-proc box.  Is that the
>kind of thing you want testing on?  If you want to send me some testing
>scripts, I'll run them.  
>
>  
>
Yes, that would be cool.

Green, please respond to this email with details for him.

-- 
Hans


