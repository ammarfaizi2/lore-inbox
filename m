Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267713AbTBMCcH>; Wed, 12 Feb 2003 21:32:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267711AbTBMCcH>; Wed, 12 Feb 2003 21:32:07 -0500
Received: from mail.webmaster.com ([216.152.64.131]:28861 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S267709AbTBMCcF> convert rfc822-to-8bit; Wed, 12 Feb 2003 21:32:05 -0500
From: David Schwartz <davids@webmaster.com>
To: <jamie@shareable.org>
CC: <cfriesen@nortelnetworks.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Mailer: PocoMail 2.63 (1077) - Licensed Version
Date: Wed, 12 Feb 2003 18:41:53 -0800
In-Reply-To: <20030213022127.GB13897@bjl1.jlokier.co.uk>
Subject: Re: Monta Vista software license terms
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Message-ID: <20030213024154.AAA23702@shell.webmaster.com@whenever>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Feb 2003 02:21:27 +0000, Jamie Lokier wrote:
>David Schwartz wrote:

>>    1) I have all the rights to the difference between the original
>>work
>>and the derived work. (Since I made the derived work, I must.)

>The logic of derivation does not work like that.
>You don't have all the rights to the difference.

>It is not a case of B = C - A.  People do not own individual lines 
>or
>bytes of the source code.  (Sometimes they do, but often they 
>don't).

>The "difference" between the original work and the derived work is
>_itself_ a derived work, because you can't possibly *create* a diff
>without deriving from the original work.

	I don't think you understand what I mean by "difference". It's not a 
precise mathematical term and it doesn't refer to 'diff' output. It 
means the rights to the derived work apart from the rights to the 
original work.

>In the act of you creating the diff you must have worked from the
>original GPL'd work, so the diff is derived from that, as well as
>from
>your original work.  When you write "diff -ur orig-kernel my-kernel
>>file", the output from that command is a derived work of the
>orig-kernel directory.

	Certainly, but that's not what I'm talking about.

>This is true even if you didn't copy any context lines from the
>original tree.
>
>That means your difference is covered by the GPL, even though you
>wrote the changes.

	Of course the original work is covered by the GPL and of course the 
derived work as a whole is covered by the GPL to the extent that the 
original work is covered by the GPL.

>(If you did manage to write the same diff working from other 
>sources,
>or if the diff only makes "fair use" of the original, that would be
>different.  But any large, complex diff such as a patch to the Linux
>VM simply cannot be written without starting from the original Linux
>VM
>code.  It is a question of how well the glove fits the hand, as it
>were).

	When I say 'difference', I don't mean the output of a 'diff'. I mean 
the literal subtraction. I mean the derived work less the original 
work. Or, to put it another way, the rights to the output of the 
additional creative effort added by the person who made the derived 
work.

>(If the difference was just whole files using a well defined
>interface, such as a device driver or filesystem, your point seems
>quite applicable though.)

	Suppose you write a play and then I write an adaptation of that play 
in the form of a screenplay for a motion picture. To produce a motion 
picture based upon my screenplay, you would need certain specific 
rights to your play and certain specific rights to my adaptations. By 
"difference" I mean the rights to the adaptations themselves. I do 
agree that it is nonsensical to have, say, distribution rights to the 
adaptations without rights to the original.

	In other words, to have distribution rights to the derived work, you 
must have distribution rights to the original. You must also have 
distribution rights to the "difference". This is a notional legal 
thing, there does not have to exist such a "difference" as an actual 
object.

	Consider if I translate a book you wrote. To distribute the 
translation, you need the right to distribute the original work, the 
right to make the translation, and other rights to the "difference", 
that is, the right to distribute the translation apart for the right 
to distribute the original work.

	I think you're hung up on my use of terminology. If you don't like 
the word "difference" substitute "derived work apart from the 
original work".

	For example, if I translate your book into another language, the 
thing you need to get from me to distribute the translation is what I 
call the "right to distribute the difference", but of course there is 
no actual "difference". Call it the "right to distribute the 
translation apart from the right to distribute the original work" or 
the "right to distribute the additional creative work added in the 
derivation process".

	It's a complex and technical legal issue, but I'm not doing anything 
unusual with it. See, for example, section 103 which states:

"The copyright in a compilation or derivative work extends only to 
the material contributed by the author of such work, as distinguished 
from the preexisting material employed in the work, and does not 
imply any exclusive right in the preexisting material."

	DS


