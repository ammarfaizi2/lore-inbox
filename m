Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267893AbTBLWVd>; Wed, 12 Feb 2003 17:21:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267889AbTBLWVd>; Wed, 12 Feb 2003 17:21:33 -0500
Received: from mail.webmaster.com ([216.152.64.131]:62392 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S267887AbTBLWV2> convert rfc822-to-8bit; Wed, 12 Feb 2003 17:21:28 -0500
From: David Schwartz <davids@webmaster.com>
To: <Valdis.Kletnieks@vt.edu>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Mailer: PocoMail 2.63 (1077) - Licensed Version
Date: Wed, 12 Feb 2003 14:31:13 -0800
In-Reply-To: <200302122143.h1CLhApk010133@turing-police.cc.vt.edu>
Subject: Re: Monta Vista software license terms
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Message-ID: <20030212223115.AAA18900@shell.webmaster.com@whenever>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Feb 2003 16:43:10 -0500, Valdis.Kletnieks@vt.edu wrote:
>On Wed, 12 Feb 2003 13:30:21 PST, David Schwartz said:

>>You already have the right to produce derivative works.

>No. At least in the US, 17 USC 106 says producing a derivative right
>is reserved to the
>copyright holder, except for the cases enumerated in 17 USC 107-121.

>So if you're producing a derivative work without having gotten the
>rights to do so, you're screwed in the legal sense.

	You have been given that right. The GPL, without clause 2, gives you 
the right to use the work (see citation below). For source code, the 
only way to use it is to produce derivative works.

>Clause 2 of the GPL gives you the right to produce derivative works 
>*IF*
>you accept the conditions.  Having accepted that clause, you're
>bound by
>it - that's what makes the GPL work.
>
>Please enumerate what *OTHER* way you are getting the right to
>produce a
>derivative work, rather than via the GPL clause 2.  (Note that this 
>*could*
>happen, if for instance code is dual-licensed and you are getting
>the right via the other license).

	The GPL says:

"Activities other than copying, distribution and modification are not
covered by this License; they are outside its scope.  The act of
running the Program is not restricted, and the output from the 
Program is covered only if its contents constitute a work based on 
the Program (independent of having been made by running the Program).
Whether that is true depends on what the Program does."

	Please explain to me, say for the case of the Linux kernel source 
code, how you can run it without first producing a derivative work. 
Granting a person the right to *use* source code means granting them 
the right to produce derivative works of that source code because 
that is how source code is used.

	How can I use the Linux kernel, say on an FTP site or a CD that I 
ordered, without copying it onto my computer? How can I compile it 
without copying it into memory?

	You cannot use a C source file without modifying it. In order to 
compile it, you must pass it through a preprocessor. This produces a 
modified copy of the original.

	Source code is like a recipe. The right to use it implicitly 
includes the right to follow the recipe and eat the results because 
that is how one uses a recipe. Along the way, one makes copies and 
derived works. It's simply unavoidable.

	This doesn't mean that all copying and modifying is automatically 
allowed for all cases where you have the right to use source code. 
However, it does mean that absent a restrictive agreement to the 
contrary that limits your *usage* rights, you can create derived 
works and you can make copies because that's how you use source code. 

	You can't give the derived works or copies to those who have no 
right to the original work (because you can't give others rights to 
code that is not yours). However, no special right to the original 
work is needed to distribute derived works among those who already 
have the right to use and possess the original work and make the 
derived works.

	In the case of the GPL, you even have the additional right to 
distribute the original work. I would argue that you can distribute 
derived works even without the right to distribute the original 
provided all recipients have the right to use and possess the 
original. But this argument isn't even needed.

>Note again that two of these rights (distribute the original,
>distribute
>the modifications) are *NOT* ones you inherently have - you are
>getting them
>*WITH RESTRICTIONS* on what you can and can't do (see clause 2
>again).

	No, that is not true. The GPL says:

"1. You may copy and distribute verbatim copies of the Program's
source code as you receive it, in any medium, provided that you
conspicuously and appropriately publish on each copy an appropriate
copyright notice and disclaimer of warranty; keep intact all the
notices that refer to this License and to the absence of any 
warranty; and give any other recipients of the Program a copy of this 
License along with the Program."

	There are no significant restrictions placed upon the distribution 
of the original work. Even if there were, it's not clear that it 
would be enforceable considering that you are only distributing the 
work to people who already have the right to possess and use it. 
There are only a small number of cases on this point and they're 
split both ways. In all the cases where the copyright holder 
prevailed (such as the lawsuit against mp3.com), it was based on a 
showing that such distribution foreclosed on their sales, an argument 
that could not be made in the case of the GPL. So this could be 
argued either way even without clause 1.

	As for distributing modifications, as I have already argued at least 
four times now, this is not a special right to the *original* work so 
there is no need to invoke clause 2 to get that right. It is subsumed 
under the right to make derivative works and the right to distribute 
the original work. It is the simple sum of those two rights (except 
the additional rights you need to the modifications themselves).

	To make and distribute a derived work, you need certain rights to 
the original work. Specifically, you need the right to make the 
derived work in the first place and you need the right to distribute 
the original work. I am saying that you have both of these rights 
without clause 2. It is even arguable that you have them without 
clause 1.

	This will be the last time I repeat myself. I promise. I will not 
respond to this thread unless something genuinely new comes up.

	DS


