Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262227AbUK3RIu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262227AbUK3RIu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 12:08:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262207AbUK3RFf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 12:05:35 -0500
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:50868 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S262227AbUK3RDK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 12:03:10 -0500
Message-ID: <41ACA7C9.1070001@namesys.com>
Date: Tue, 30 Nov 2004 09:03:05 -0800
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Horst von Brand <vonbrand@inf.utfsm.cl>
CC: Peter Foldiak <Peter.Foldiak@st-andrews.ac.uk>,
       Christian Mayrhuber <christian.mayrhuber@gmx.net>,
       reiserfs-list@namesys.com,
       Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: file as a directory
References: <200411301631.iAUGVT8h007823@laptop11.inf.utfsm.cl>
In-Reply-To: <200411301631.iAUGVT8h007823@laptop11.inf.utfsm.cl>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Horst von Brand wrote:

>Peter Foldiak <Peter.Foldiak@st-andrews.ac.uk> said:
>  
>
>>On Tue, 2004-11-30 at 14:51, Horst von Brand wrote:
>>    
>>
>>>>I was suggesting this idea mainly form XML files, where the tags define 
>>>>the parts clearly.
>>>>        
>>>>
>
>  
>
>>>Use a XML parsing library then.
>>>      
>>>
>
>  
>
>>But namespace unification is important,
>>    
>>
>
>Why? Directories are directories, files are files, file contents is file
>contents. Mixing them up is a bad idea. Sure, you could build a filesystem
>of sorts (perhaps more in the vein of persistent programming, or even data
>base systems) where there simply is no distinction (because there are no
>differences to show), but that is something different.
>  
>
This is kind of like explaining to people around the office that they 
could ever possibly need a disk drive of more than 10mb back in 1982 or 
so.  I could not convince them then, Peter, you cannot convince this guy 
now, just spend the time coding it instead.  Peter, you expect people to 
understand the value of features they have never used.  Works for some 
of them.  Only some of them.

>  
>
>>                                        and to unify the namespace, you
>>have to use the same syntax. I guess you disagree with me on that. (If
>>not, how would you do it?)
>>    
>>
>
>I'd go one level up: Eliminate the distinctions that bother you, not try to
>patch over them.
>  
>
Are you saying you'd rewrite xml to put separate objects in separate 
files? 
