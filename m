Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265868AbRFYDov>; Sun, 24 Jun 2001 23:44:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265869AbRFYDom>; Sun, 24 Jun 2001 23:44:42 -0400
Received: from 64-42-29-14.atgi.net ([64.42.29.14]:44296 "HELO
	mail.clouddancer.com") by vger.kernel.org with SMTP
	id <S265868AbRFYDo2>; Sun, 24 Jun 2001 23:44:28 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: What are the VM motivations??
In-Reply-To: <9h6916$4og$1@ns1.clouddancer.com>
In-Reply-To: <20010621190103.A888@jmcmullan.resilience.com>    <20010624140114.A10745@jmcmullan.resilience.com>    <3B3697FB.3B7F098@247media.com> <01062504534600.16346@starship> <3B3697FB.3B7F098@247media.com> <9h6916$4og$1@ns1.clouddancer.com>
Reply-To: klink@clouddancer.com
Message-Id: <20010625034427.65260784D9@mail.clouddancer.com>
Date: Sun, 24 Jun 2001 20:44:27 -0700 (PDT)
From: klink@clouddancer.com (Colonel)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In clouddancer.list.kernel, you wrote:
>
>On Monday 25 June 2001 03:46, Russell Leighton wrote:
>> I read this thread as asking the question:
>>
>>     If VM management is viewed as an optimization problem,
>>     then what exactly is the function that you are optimizing and what are
>> the constraints?
>>
>> If you could express that well with a even a very loose model, then
>> the code could be reviewed to see if it was really doing what was intended
>> and assumptions could be tested.
>
>May I suggested an algorithm?
>
>  - Write down what you think the optimization constraints are.
>    (be specific, for example, enumerate all the flavors of page types -
>    process code, process data, page cache file data, page cache swap
>    cache, anonymous, shmem, etc.)
>
>  - Write down what you think the current algorithms are.
>    (again, be specific, use file names, function names, pseudocode and 
>    snippets of existing code.)
>
>  - Send it to Rik.  He'll tell you if it's right.

POST IT.  Give the rest of us some clues and the opportunity to check
evaluator's replies.
