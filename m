Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292349AbSBPJvz>; Sat, 16 Feb 2002 04:51:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292346AbSBPJvp>; Sat, 16 Feb 2002 04:51:45 -0500
Received: from [195.63.194.11] ([195.63.194.11]:21519 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S292345AbSBPJvf>; Sat, 16 Feb 2002 04:51:35 -0500
Message-ID: <3C6E2B82.407@evision-ventures.com>
Date: Sat, 16 Feb 2002 10:50:58 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: esr@thyrsus.com, Dave Jones <davej@suse.de>,
        Arjan van de Ven <arjan@pc1-camc5-0-cust78.cam.cable.ntl.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Disgusted with kbuild developers
In-Reply-To: <E16brCy-0004XZ-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

>>Alan Cox <alan@lxorguk.ukuu.org.uk>:
>>
>>>Since the information is there in CML1 to generate the list of constraints
>>>for any given option,
>>>
>>False assumption...
>>
>
>Do you have anything more constructive that "doesnt" to say
>
>>If you want to refute me, build it yourself.  You'll get a valuable learning
>>experience.  At the end of it, I'll have earned your apology.  Not that I
>>expect to get it.
>>
>
>Been there, done that, got the pretty graphs. Possibly the next step is to
>redo the work into mconfig which already does pretty much anything we need
>with the existing config files parsed using a real 100% genuine yacc grammar
>
I second this. mconfig is a fine lean and sane design, which isn't 
trying to solve the "world hunger" problem.




