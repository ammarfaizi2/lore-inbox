Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319623AbSIMMj3>; Fri, 13 Sep 2002 08:39:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319625AbSIMMj3>; Fri, 13 Sep 2002 08:39:29 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:18707 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S319623AbSIMMj2>; Fri, 13 Sep 2002 08:39:28 -0400
Message-ID: <3D81DD9E.4050303@namesys.com>
Date: Fri, 13 Sep 2002 16:44:14 +0400
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bill Davidsen <davidsen@tmr.com>
CC: Nikita Danilov <Nikita@Namesys.COM>, Bryan Whitehead <driver@jpl.nasa.gov>,
       Nick LeRoy <nleroy@cs.wisc.edu>, jw schultz <jw@pegasys.ws>,
       linux-kernel@vger.kernel.org
Subject: Re: XFS?
References: <Pine.LNX.3.96.1020913072112.22464A-100000@gatekeeper.tmr.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Davidsen wrote:

>On Thu, 12 Sep 2002, Nikita Danilov wrote:
>
>  
>
>>Then you missed "reiserfs inclusion into the kernel" soap opera.
>>
>>And besides, reiserfs in mainline to no extent means reiser4 in mainline
>>(unfortunately).
>>    
>>
>
>No, that's probably a good thing. I don't care how good any programming
>team might be, an implementation written from scratch probably should burn
>in for a while before going in anywhere it might be used for production.
>
>And with all respect to the group, a 4th rewite from scratch in only a few
>years suggests that the ratio of coding to designing is pretty high.
>
>  
>
Version 3 came out in 1998 or so, and large software projects should be, 
but rarely are, rewritten from scratch every 5 years.  If you want to 
object to XFS, object that it hasn't been rewritten in recent times.

As for the notion that the more designing you do, the less rewriting you 
need to do, it is a bit like the belief that the better your scientific 
theories the less you need to perform experiments.

Projects that are no longer attempting rewrites of their cores are dead 
in their soul, and their authors should pass them on to someone younger.

That said, version 4 will be followed by semantic enhancements and 
distributed filesystem work, as I finally have in version 4 a storage 
layer good enough that I can move mostly to the tasks that first 
interested me about FS design.  Most of the stuff that needs improvement 
in the version 4 storage layer can be done as new plugins, or so I 
fondly hope.;-)

Hans

