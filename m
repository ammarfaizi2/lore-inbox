Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264855AbTLEXQq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 18:16:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264867AbTLEXQq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 18:16:46 -0500
Received: from bm-1a.paradise.net.nz ([202.0.58.20]:49054 "EHLO
	linda-1.paradise.net.nz") by vger.kernel.org with ESMTP
	id S264855AbTLEXQj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 18:16:39 -0500
Date: Sat, 06 Dec 2003 12:16:51 +1300
From: Oliver Hunt <ojh16@student.canterbury.ac.nz>
Subject: Re:
In-reply-to: <S264322AbTLERgM/20031205173643Z+1105@vger.kernel.org>
To: gmack@innerfire.net, linux-kernel@vger.kernel.org
Message-id: <3FD111E3.8010606@student.canterbury.ac.nz>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=us-ascii
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5)
 Gecko/20031013 Thunderbird/0.3
References: <S264322AbTLERgM/20031205173643Z+1105@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

No its not, doing something similar to (or identical) to a GPL'd program 
is fine, if you were to use a GPL'd IRC server/client as the base for 
your own code, then you'd need to pblish using the GPL...

IRC would be in the realm of software patents really - it's a protocol - 
the client/serverside code comes under copyright laws :)

--Oliver

gmack@innerfire.net wrote:

>From gmack@innerfire.net  Fri Dec  5 12:36:11 2003
>Received: from localhost (sendmail-bs@127.0.0.1)
>  by localhost with SMTP; 5 Dec 2003 17:36:11 -0000
>Date: Fri, 5 Dec 2003 12:36:11 -0500 (EST)
>From: Gerhard Mack <gmack@innerfire.net>
>To: Linus Torvalds <torvalds@osdl.org>
>cc: David Schwartz <davids@webmaster.com>, Valdis.Kletnieks@vt.edu, 
>    Peter Chubb <peter@chubb.wattle.id.au>, linux-kernel@vger.kernel.org
>Subject: RE: Linux GPL and binary module exception clause? 
>In-Reply-To: <Pine.LNX.4.58.0312042245350.9125@home.osdl.org>
>Message-ID: <Pine.LNX.4.58.0312051232530.16547@innerfire.net>
>References: <MDEHLPKNGKAHNMBLJOLKMEIDIHAA.davids@webmaster.com>
> <Pine.LNX.4.58.0312042245350.9125@home.osdl.org>
>MIME-Version: 1.0
>Content-Type: TEXT/PLAIN; charset=US-ASCII
>X-Spam-Status: No, hits=-104.5 required=4.0 tests=IN_REP_TO,SUBJ_ENDS_IN_Q_MARK,USER_IN_WHITELIST version=2.20
>X-Spam-Level: 
>
>Those views are scary when you consider that webmaster Inc sells closed
>source software that works exactly like IRC (wich is GPL)
>
>On Thu, 4 Dec 2003, Linus Torvalds wrote:
>
>  
>
>>Date: Thu, 4 Dec 2003 22:58:09 -0800 (PST)
>>From: Linus Torvalds <torvalds@osdl.org>
>>To: David Schwartz <davids@webmaster.com>
>>Cc: Valdis.Kletnieks@vt.edu, Peter Chubb <peter@chubb.wattle.id.au>,
>>     linux-kernel@vger.kernel.org
>>Subject: RE: Linux GPL and binary module exception clause?
>>
>>
>>
>>On Thu, 4 Dec 2003, David Schwartz wrote:
>>    
>>
>>>The GPL gives you the unrestricted right to *use* the original work.
>>>This implicitly includes the right to peform any step necessary to use
>>>the work.
>>>      
>>>
>>No it doesn't.
>>
>>Your logic is fundamentally flawed, and/or your reading skills are
>>deficient.
>>
>>The GPL expressly states that the license does not restrict the act of
>>"running the Program" in any way, and yes, in that sense you may "use" the
>>program in whatever way you want.
>>
>>But that "use" is clearly limited to running the resultant program. It
>>very much does NOT say that you can "use the header files in any way you
>>want, including building non-GPL'd programs with them".
>>
>>In fact, it very much says the reverse. If you use the source code to
>>build a new program, the GPL _explicitly_ says that that new program has
>>to be GPL'd too.
>>
>>    
>>
>>>Please tell me how you use a kernel header file, other than by including
>>>it in a code file, compiling that code file, and executing the result.
>>>      
>>>
>>You are a weasel, and you are trying to make the world look the way you
>>want it to, rather than the way it _is_.
>>
>>You use the word "use" in a sense that is not compatible with the GPL. You
>>claim that the GPL says that you can "use the program any way you want",
>>but that is simply not accurate or even _close_ to accurate. Go back and
>>read the GPL again. It says:
>>
>>	"The act of running the Program is not restricted"
>>
>>and it very much does NOT say
>>
>>	"The act of using parts of the source code of the Program is not
>>	 restricted"
>>
>>In short: you do _NOT_ have the right to use a kernel header file (or any
>>other part of the kernel sources), unless that use results in a GPL'd
>>program.
>>
>>What you _do_ have the right is to _run_ the kernel any way you please
>>(this is the part you would like to redefine as "use the source code",
>>but that definition simply isn't allowed by the license, however much you
>>protest to the contrary).
>>
>>So you can run the kernel and create non-GPL'd programs while running it
>>to your hearts content. You can use it to control a nuclear submarine, and
>>that's totally outside the scope of the license (but if you do, please
>>note that the license does not imply any kind of warranty or similar).
>>
>>BUT YOU CAN NOT USE THE KERNEL HEADER FILES TO CREATE NON-GPL'D BINARIES.
>>
>>Comprende?
>>
>>		Linus
>>-
>>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>>the body of a message to majordomo@vger.kernel.org
>>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>Please read the FAQ at  http://www.tux.org/lkml/
>>
>>    
>>
>
>--
>Gerhard Mack
>
>gmack@innerfire.net
>
><>< As a computer I find your faith in technology amusing.
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>  
>

