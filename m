Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318562AbSGZUM1>; Fri, 26 Jul 2002 16:12:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318564AbSGZUM0>; Fri, 26 Jul 2002 16:12:26 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:27149 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S318562AbSGZUMH>; Fri, 26 Jul 2002 16:12:07 -0400
Message-ID: <3D41ADD3.9010509@namesys.com>
Date: Sat, 27 Jul 2002 00:15:15 +0400
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jose Luis Domingo Lopez <linux-kernel@24x7linux.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: How to start on new db-based FS?
References: <20020726160742.GA951@ksu.edu> <20020726190520.GA3192@localhost>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jose Luis Domingo Lopez wrote:

>On Friday, 26 July 2002, at 11:07:42 -0500,
>Johnny Q. Hacker wrote:
>
>  
>
>>I'm looking to start work in the next half-year to year on a filesystem
>>  with LDAP and then maybe later someSQL backing.  Where's a good place
>>  to start?  I'm going to have a look at NFS, because I think I might
>>  be able to use its interface into the kernel (I'm planning on making
>>  it a userspace daemon).  Maybe autofs, although I think that's a
>>  different interface.
>>
>>    
>>
>Just a pointer to a project on filesystems that seems "revolutionary" in
>concepts and objectives: ReiserFS 4 (http://www.namesys.com).
>
>Please don't ask me about details, because I don't know a thing about
>filesystem design and such :-), but documentation at the above site can 
>give you some ideas, and maybe a place to start contributing.
>
>Regards, 
>
>  
>
We would be happy to cooperate with persons interested in implementing 
LDAP optimizing plugins for reiser4.

Probably you can get decent results compared to the competition even 
without writing additional plugins.

-- 
Hans



