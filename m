Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261580AbULTRVn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261580AbULTRVn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 12:21:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261581AbULTRVn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 12:21:43 -0500
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:45743 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S261580AbULTRVk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 12:21:40 -0500
Message-ID: <41C70A1F.8000609@namesys.com>
Date: Mon, 20 Dec 2004 09:21:35 -0800
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Horst von Brand <vonbrand@inf.utfsm.cl>
CC: David Masover <ninja@slaphack.com>,
       Peter Foldiak <Peter.Foldiak@st-andrews.ac.uk>,
       reiserfs-list@namesys.com, linux-kernel@vger.kernel.org,
       Nate Diller <ndiller@namesys.com>
Subject: Re: file as a directory
References: <200412180152.iBI1q98X007507@laptop11.inf.utfsm.cl>
In-Reply-To: <200412180152.iBI1q98X007507@laptop11.inf.utfsm.cl>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Horst von Brand wrote:

>
>>>Can you point me to any such literature?  I'm just curious.
>>>      
>>>
>
>  
>
>>Look in every field of cs except filesystems and kernels.;-)
>>    
>>
>
>Right. Smart people are found elsewhere only.
>  
>
There is a huge pile of innovations by the database field that 
filesystems people do not yet make use of.  The merits of 
interdisciplinary study are understood by many.

>  
>
>>                                                             Databases, 
>>garbage collectors, etc.
>>    
>>
>
>Everthing stuff that works on the assumption that what they are working on
>fits in RAM (or can overflow into swap space in a pinch), and that RAM is
>fast (and even so they are infuriatingly slow). And disks are usually a few
>thousand times larger than RAM (more stuff to shuffle around) and a million
>times slower...
>
>  
>
>>                         Specific reference, no, I didn't collect them, 
>>sorry, but alexander the befs driver guy knows more than I about this.
>>    
>>
>
>Furious handwaving doesn't make it true.
>  
>
Ok, go talk to the befs driver guy, and you'll find out he has already 
done work on it.

If his work does not satisfy you, sorry, I do detailed research just 
before coding, not to satisfy some guy on lkml.
