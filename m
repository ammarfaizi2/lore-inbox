Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262395AbULOQ5f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262395AbULOQ5f (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 11:57:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262396AbULOQ5e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 11:57:34 -0500
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:53750 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S262395AbULOQ5W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 11:57:22 -0500
Message-ID: <41C06CF7.2020102@namesys.com>
Date: Wed, 15 Dec 2004 08:57:27 -0800
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Horst von Brand <vonbrand@inf.utfsm.cl>
CC: Peter Foldiak <Peter.Foldiak@st-andrews.ac.uk>, reiserfs-list@namesys.com,
       linux-kernel@vger.kernel.org
Subject: Re: file as a directory
References: <200412151328.iBFDSQoH011241@laptop11.inf.utfsm.cl>
In-Reply-To: <200412151328.iBFDSQoH011241@laptop11.inf.utfsm.cl>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Horst von Brand wrote:

>Hans Reiser <reiser@namesys.com> said:
>  
>
>>Horst von Brand wrote:
>>    
>>
>>>Peter Foldiak <Peter.Foldiak@st-andrews.ac.uk> said:
>>>      
>>>
>
>  
>
>>>[...]
>>>      
>>>
>
>  
>
>>>>Perhaps a better way to think about this is that instead of talking
>>>>about directories and files, we just talk about objects.
>>>>        
>>>>
>
>  
>
>>>Then you have a collection of interrelated objects, i.e., a database.
>>>Operating systems that work on databases (no filesystem) have been done,
>>>and are a nice idea... but are far, far away from Unix.
>>>      
>>>
>
>  
>
>>A journey of a thousand leagues begins with a single step.
>>    
>>
>
>Right.  But you need to know where you are going, and why.
>
>  
>
>>Actually, databases are the wrong solution because they are relational, 
>>    
>>
>
>Says who?
>  
>
Read the

www.namesys.com/future_vision.html

paper for why relational is the wrong model.

>  
>
>>and what is needed is a semi-structured query language that is upwardly 
>>compatible with Unix hierarchical semantics, ala 
>>www.namesys.com/future_vision.html
>>    
>>

