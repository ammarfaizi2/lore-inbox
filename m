Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267226AbTAFVzq>; Mon, 6 Jan 2003 16:55:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267225AbTAFVzq>; Mon, 6 Jan 2003 16:55:46 -0500
Received: from mail.webmaster.com ([216.152.64.131]:31936 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S267223AbTAFVzl> convert rfc822-to-8bit; Mon, 6 Jan 2003 16:55:41 -0500
From: David Schwartz <davids@webmaster.com>
To: <ml-linux-kernel@studentenwerk.mhn.de>
CC: <linux-kernel@vger.kernel.org>, <rms@gnu.org>
X-Mailer: PocoMail 2.63 (1077) - Licensed Version
Date: Mon, 6 Jan 2003 14:04:15 -0800
In-Reply-To: <200301061724.21596.ml-linux-kernel@studentenwerk.mhn.de>
Subject: Re: Why is Nvidia given GPL'd code to use in non-free drivers?
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-ID: <20030106220416.AAA29779@shell.webmaster.com@whenever>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Jan 2003 17:24:21 +0100, Wolfgang Walter wrote:
>On Sunday 05 January 2003 06:35, David Schwartz wrote:
>>On Sun, 5 Jan 2003 05:39:35 +0100, Wolfgang Walter wrote:
>>>On Sunday 05 January 2003 01:17, David Schwartz wrote:
>>>>On Sat, 04 Jan 2003 18:44:58 -0500, Richard Stallman wrote:

>>Sounds like every shrink wrap agreement in the world. You
>>already
>>have the thing you want to license, the licensee simply refuses to
>>grant you the rights to that thing you already have unless you
>>agree
>>to a license that you are not free to negotiate.

>A shrink wrap agreement is something completely different.  You must
>differentiate between using software and the exploitation right of 
>the copyright-user.

	You can aim this criticism at many other people in this 
conversation, but not me. I think I'm the only one who does 
differentiate clearly.	

>Say you buy a book. Reading it ist usage.

	Really? How do you read a book? You bounce a light off it and make a 
copy of the book on your retina, right? In other words, you use 
things by copying them.

>Destroing it is usage. But
>writing a
>book which contains part of this book is not using it. Lending it in
>public
>libraries is not usage. Making copies and distribute them is not
>usage.

	Yes, copies *of* *that* *book*. But when you make a copy of the book 
on your retina, your eyes and brain are not a derived work. When you 
use photoshop, the graphics you create are not a derived work.

	I submit that the *only* way to use a header file is to include it 
in a source file, and compile and copy the resultant output. Note 
that you cannot run a program without copying it. It's physically 
impossible.

>You don't need a license from the author to use the book.

	Right, because we recognize that a graphic created with photoshop is 
*not* a derived work of photoshop. A brain that has read a book is 
not a derived work of that book. Similary, a program whose source 
code includes a header file should not be considered a derived work 
of that header file.

>A shrink wrap license agreement (or EULA) tries to restrict your
>rights to USE
>your bought copy THOUGH you didn't bought it from the person who
>wants you to
>do so and AFTER you bought it. With the book-example: you may only
>read it by
>night and you are not allowed to speak bad of it.

	Tell me how you use a computer program without copying it. Please, 
do that. How do you use a CD without making a copy of the data on it?

	Use and copying are the same when it comes to information. There is 
no other way to use information. This is why it's critical to 
strengthen fair use, first sale, and necessary step type defenses.

	You can't use a header file without including it in source code. You 
can't use the resultant object file without copying it. Thus these 
*must* be fair uses.

>In Germany microsoft tried to inhibit that peoply sell there copy of
>windows
>bought with a new computer (based on there EULA which declared this
>copy as
>OEM and only valid together with this computer). They failed of
>course -
>there is no license-agreement between the owner of this windows-copy
>and
>microsoft. I didn't license the copy, I bought it and own it. And to
>own
>software is enough to use it. They can't restrrict unilaterally my
>right to
>use it.

	How can you use Windows without copying it from your hard drive into 
memory? Copying is using. Using is copying.

>If he has to modify the kernel to load the module, then of course he
>has to
>accept the GPL because modifing the kernel is not using it. And then
>the GPL
>may forbid him to do so.

	Modifying the kernel is not using it? A copy of the kernel is RAM is 
different from a copy of the kernel on hard drive. This is a 
transformative modification. You cannot use the linux kernel without 
modifying it. And guess what? When you run the Linux kernel, are the 
data structure you thereby create in your memory derived works?

>I see (you state that below) that you think that using header files
>in
>software-projects is not making a derived work from those header
>files but
>instead using them.

	Tell me how else you can use them. Please. Go ahead. Tell me any 
other way to use a header file other than to include it in a source 
file, compile that source file, and then copy the resulting 
executable.

>>Stallman *does* argue that Linux binary modules are derived works.

>I don't know if he does.

	Then he is arguing to weaken fair use, first sale, and necessary 
step type principles. These are far more important than the GPL.

>If the source code of binary-modules do not contain copyrighted
>material from
>the kernel they probably not derived works. Loading the module into
>the
>kernel by the user may produce a derived work. Putting kernel and
>modules
>together in a distribution may produce a derived work.

	No, because these are all necessary steps. A necessary step to use 
is always use. You cannot use the kernel without copying it into 
memory. You cannot use the kernel without feeding it information and 
having it produce structure in memory.

	Stallman is out to destroy fair use. Whether you knows it or admits 
it or not.

>Using kernel header files to produce the binary is very probably
>making a
>derived work. But it would be rather hard to prove that - as it is
>so easy to
>reverse engineer open source software and write your own header
>files.

	So tell me how else you use kernel header files. What else can you 
do with a header file?!

>>    To support the GPL's ability to regulate the distribution of
>>derived
>>works you would have to argue that Adobe's EULA could legitimately
>>prohibit you from distributing images you create with photoshop.

>A image produced with photoshop is not a derived work. It does not
>contain
>photoshop. If you use a nice picture they delivered with photoshop
>as base
>then of course you may need a license.

	Exactly. All photoshop can do is produce images. Therefore producing 
images with photoshop is use, barring some exceptional circumstance. 
(For example, if you take an image from their clip art.)

>>smarter for advocates of freedom to argue that this is fair use and
>>the argument that such works are derived is bullcrap.

>Fair use is something different. Fair use is about exploitation
>right without
>permission of the copyright holder. I.e. you may cite a book in your
>book
>(but you may not print a whole page or so). Making a copy of a book
>for
>private use without permission of the copyright holder. (In Germany
>i.a. you
>pay for this right: on every copy-device as cd-burners, printers,
>and on
>memories like harddiscs, blank CDs, etc. there are fees).

	Fair use includes any number of ways you can do things you might not 
normally be able to do. This includes 'necessary step' (this is why 
you can make a copy of a book on your retina) and 'firs sale' type 
rights.

>For software there is almost no fair use in the EU. I.e. the right
>for private
>copies does not exist.

	Then you can't use software at all. Installing from a CD is a 
private copy. Loading into memory is a private copy. You can't mean 
what you're saying. Either you're confused or the EU is utterly 
insane.

>The one who compiles it using the kernel header files makes a
>derived work -
>the binary is a derived work. But thats my opinion. You thinks that
>it is
>using them.

	How else can you use a header file other than to include it in a 
source file that you subsequently compile. This is how header files 
are intended to be used. This is like making a copy of a book on your 
retina. It's the only way to use it, so it *must* be use.

	These are the arguments the 'free software' (as in freedom) crowd 
should be making, not opposing.

	DS


