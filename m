Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261791AbTILTdf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 15:33:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261818AbTILTdf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 15:33:35 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:24068 "HELO
	kinesis.swishmail.com") by vger.kernel.org with SMTP
	id S261791AbTILTdU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 15:33:20 -0400
Message-ID: <3F6224C6.1020305@techsource.com>
Date: Fri, 12 Sep 2003 15:55:50 -0400
From: Timothy Miller <miller@techsource.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Schwartz <davids@webmaster.com>
CC: Pascal Schmidt <der.eremit@email.de>, linux-kernel@vger.kernel.org
Subject: Re: People, not GPL  [was: Re: Driver Model]
References: <MDEHLPKNGKAHNMBLJOLKAEHGGHAA.davids@webmaster.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



David Schwartz wrote:
>>But I have another point.  You are not dealing with a license here.  The
>>license is there to satisfy lawyers and make clear the INTENT of the
>>authors.  The keyword here is INTENT in that someone who has developed
>>something is telling you how they feel about the use of their work
>>which, under many circumstances, they could have chosen not to share
>>with you.  What you are dealing with is real people who have put an
>>incredible amount of time and effort into developing Linux.  Those
>>people, to whom you owe much respect for sharing their contributions,
>>have decided that their software should be used with certain
>>restrictions, that being the GPL.  If you abuse Linux, it is not the GPL
>>that you are insulting, but the people who developed Linux.
> 
> 
> 	In other words, information does not want to be free. You shouldn't use
> code the way you want to use it but the way the authors want you to use it.
> After all, they didn't have to give it to you if they didn't want to.

EXACTLY.  Fortunately in this case, the authors place few restrictions 
on your usage.  Indeed, the "restrictions" are more a matter of being 
nice to the people who made the stuff you're using.

You're stuck thinking about "law" and "rules".  I'm thinking instead 
about "honor".

One of the (unresolved) discussions I had with RMS involved the role of 
the author.  He believes that the user is more important than the 
author.  I believe the author is more important, because had the author 
not written what the user has, then the user would not have it! 
Actually, he partially agrees with me but does not feel that the author 
should be able to apply restrictions (IF the work is PUBLISHED).


> 	However, Richard Stallman does not agree with this view. It's his view that
> if the authors chose to give you the code, you can use it any way you want
> to, regardless of how the authors feel about that type of usage. This is why
> he created the GPL.

But it seems clear to me that the GPL places some very strong 
restrictions on your usage.  Those restrictions are that although your 
specific usage of the code doesn't matter, anything (published) that you 
derive from GPL work MUST also be published under GPL.

So my point is that when someone publishes something under GPL that you 
find useful, give respect to the person who wrote it by obeying the 
spirit of the license.  But it is not the license that is important as 
that the author chose to release his work under those terms.  People, 
not rules; honor, not law.

There are other licenses besides the GPL.  When authors release under 
those terms, you should respect those terms as well.  The thing that 
sets the GPL apart from, say, closed-source licensing is that the GPL is 
based on a system of honor, while proprietary systems can (and often do) 
become unfairly restrictive to the users.

> 
> 
>>So, the discussions about finding ways to make a non-GPL driver look
>>like a GPL driver and get away with it legally are all moot.  The reason
>>you should not violate this is because the architects of Linux do not
>>want you to.
> 
> 
> 	If you really believe that the Linux authors wished to continue to control
> how their code was used, you have to think that they were stupid to release
> the code under the GPL. After all, the whole point of the GPL is to prohibit
> such restrictions. The reason Linux is under the GPL is so that developers
> *can't* put restrictions on how the package can be used. That's the "open"
> in open source.

The restrictions they are applying are the only ones in the GPL.  It was 
smart for them to use the GPL because it is compatible with their 
wishes.  Follow the GPL not because the GPL is a copyright license, but 
because you are grateful for the efforts of those who published under GPL.

Furthermore, if someone publishes under GPL, and your insult them, they 
may become less willing to release under GPL, thereby limiting your 
ability to rip them off.

Also, just to be pedantic, because you mentioned RMS, "open source" and 
"free software" are not the same thing.

> 
>>If you choose to violate that, you are being unethical,
>>pure and simple.  Or more to the point, you're being an asshole to a lot
>>of hard-working people who have chosen to freely share their work with
>>you.
> 
> 
> 	The person who tries to put other people's GPL'd works under his license
> restrictions is the asshole. I have contributed code to the Linux kernel
> under the GPL license (bonus points to anyone who can find my 25 lines of
> code or so). It is nobody else's right to add code to my code and add usage
> restrictions to it. The GPL expressly forbids this.

And I completely agree with all of this.  I'm getting the feeling that 
you and I don't actually disagree on any of this.  :)

The point of divergence is with regard to modules and the symbol 
restrictions for non-GPL drivers.  Here is a gray area where the GPL may 
not apply really.  These gray areas are where ethics and honor must come 
into play.

> 
>>Since they are the authors and you are not, their feelings about
>>their softare are more important than yours.
> 
> 
> 	I'm just baffled. You don't seem to understand at all why the Linux kernel
> is organized under the GPL. It's precisely so that some developers can't
> hijack the project and encumber the growing source base with usage and
> distribution restrictions.

Which is precisely why those authors placed Linux under the GPL.  If 
they didn't like that, they would be working on proprietary OS's.  I'm 
saying that people should respect the authors by honoring the GPL.

> 
>>You may be able to screw
>>them over and get away with it -- people do that sort of thing all the
>>time -- but the fact that you may find a legal loophole doesn't make you
>>any less of an abject asshole.
> 
> 
> 	The asshole is the person who thinks that they have the right to change the
> express wishes of all the other contributors to the kernel who chose to
> contribute to a project that operates under the GPL license. The GPL license
> is about there being no restrictions on usage.

Well, aside from the "it must remain free clause" (which I interpret as 
an important restriction), I agree with you.  That is to say, the 
"contributor" who hijacks the work of other contributors is being 
dishonorable, because he is not respecting the other contributors.

> 
>>In short:  Be honorable.
> 
> 
> 	I am. The hijackers are not.

Agreed.


