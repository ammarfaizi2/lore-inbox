Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267627AbTBLUI4>; Wed, 12 Feb 2003 15:08:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267626AbTBLUI4>; Wed, 12 Feb 2003 15:08:56 -0500
Received: from mail.webmaster.com ([216.152.64.131]:17590 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S267625AbTBLUIw> convert rfc822-to-8bit; Wed, 12 Feb 2003 15:08:52 -0500
From: David Schwartz <davids@webmaster.com>
To: <cfriesen@nortelnetworks.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Mailer: PocoMail 2.63 (1077) - Licensed Version
Date: Wed, 12 Feb 2003 12:18:39 -0800
In-Reply-To: <3E4A6917.2030307@nortelnetworks.com>
Subject: Re: Monta Vista software license terms
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Message-ID: <20030212201840.AAA15967@shell.webmaster.com@whenever>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Feb 2003 10:32:39 -0500, Chris Friesen wrote:
>David Schwartz wrote the following with regards to whether a company
>can restrict distribution of modified GPL'd code through an NDA:

	I apologize for continuing this. This will be my last response on 
the issue unless anyone cites actual case law.

>The problem that I see here is that the distributor is shipping the
>modified work as a whole.

	Yes, but only to people who already have the rights to use and 
possess the original work. And only by people who already have the 
right to distribute the unmodified work.

	What I'm saying is that if I want to send a derived work to you, and 
the following conditions all apply, I already have all the rights I 
need:

	1) I have all the rights to the difference between the original work 
and the derived work. (Since I made the derived work, I must.)

	2) You have the right to possess and use the original work. (The GPL 
grants everyone the right to possess and use GPL'd works without 
agreeing to the GPL's requirements.)

	3) I have the right to distribute the original work. (The GPL 
permits verbatim distribution.)

	4) I have the right to make the derived work. (The GPL must permit 
such things as they are the normal way source code is used.)

	Since all four of the conditions above apply without agreeing to the 
GPL's source disclosure terms, you can't infer agreement with the GPL 
based solely on the distribution of the modified work.

>If someone were to distribute a proprietary patch to a GPL'd piece
>of
>software along with instructions on how to apply it, then that patch
>and
>those instructions could be covered under an NDA.  However, as soon
>as
>they distribute binaries compiled from patched code, then they are
>liable under the GPL because they are distributing work derived from
>a GPL'd work.

	Under what theory? Under the theory that they didn't have the right 
to distribute the original work? The GPL gives them that right. Under 
the theory that they didn't have the right to make the derived work?

>In the case of linux, I could have a private patch and keep it
>secret
>and ship it to customers under NDA with instructions on how to apply
>it.
>As long as I do not ship it with the linux source or ship
>precompiled
>linux binaries then the GPL does not apply.  It would be a pretty
>disgusting thing to do, but I think it would be technically legal.

	You could certainly ship it with the Linux source. The GPL gives you 
the right to distribute the covered work unmodified without source 
disclosure requirements. It can't give you the right to distribute 
modified versions because those rights are not its to give.

	I'll try it again. To distribute a derived work, you need the 
following rights:

	1) The right to make and possess the derived work.

	2) The right to distribute the original work.

	3) The right to distribute the 'difference' between original and 
derived works.

	The right to distribute derived works is not an *additional* right 
to the *original* work. It is subsumed under the rights to create 
derived works and the right to distribute the original work. Of 
course, you also need the rights to the new content in the derived 
work. If anyone can cite a law or case precedent to the contrary, 
please do. Otherwise, I maintain that there is no special right to 
distribute derived works. This does not exist as a distinct right 
under copyright law in any country I know of.

>>As an example, suppose you and I both have some greeting card
>>program. I produce a greeting card that includes some graphics
>>included with the greeting card program. That greeting card is a
>>derived work. I can't distribute it to anyone I want because it
>>contains embedded graphics and I would be distributing those
>>graphics
>>to people who had no right to them.

>Usually those programs do give you the right to redistribute works
>created using the program, so your example is somewhat spurious.

	My example did not include any such right, so an example where they 
do would be your example, not mine.

>>Again, the right to possess and use a derivative work when you
>>already have the right to possess and use the original work and the
>>right to make the derivative work is not an *additional* right to
>>the
>>*original* work. I can't say it any clearer than that, and I
>>welcome
>>any citations to law or court precedent to the contrary.

>That statement seems to be true as far as it goes.  However, having
>the
>right to posess and use the original work, and the right to make a
>derivative work does *not* give you the right to distribute the
>derived
>work.

	Correct, you need the additional right to distribute the original 
work, which the GPL does give you.

>For that you fall under the GPL.  As I said earlier however,
>you
>certainly have the right to distribute modifications under any
>license
>you want, *as long as you do not distribute the modified work 
>itself*

	I'm saying that you can distribute the modified work itself. The 
only rights to the *original* work that you need to distribute a 
*modified* work is the right to make the derived work and the right 
to distribute the original work.

>As soon as you distribute the derived work, you fall under the GPL.

	You just agreed with my argument to the contrary!

>This means that the ultimate end-user would have to be the one
>applying
>the patches and compiling the derived work.

	I don't agree and my analysis above shows my reasoning.

>Like I said earlier, this would totally bypass the purpose of the
>GPL
>and I would be repulsed by a company that did this.

	I'll keep my non-legal opinions about the GPL out of it.

	DS
	

