Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266318AbTBLEDb>; Tue, 11 Feb 2003 23:03:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266116AbTBLEDb>; Tue, 11 Feb 2003 23:03:31 -0500
Received: from mail.webmaster.com ([216.152.64.131]:26015 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S266297AbTBLED2> convert rfc822-to-8bit; Tue, 11 Feb 2003 23:03:28 -0500
From: David Schwartz <davids@webmaster.com>
To: <dfawcus@cisco.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Mailer: PocoMail 2.63 (1077) - Licensed Version
Date: Tue, 11 Feb 2003 20:13:14 -0800
In-Reply-To: <20030212032530.G5553@edinburgh.cisco.com>
Subject: Re: Monta Vista software license terms
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Message-ID: <20030212041315.AAA26639@shell.webmaster.com@whenever>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Feb 2003 03:25:30 +0000, Derek Fawcus wrote:
>On Mon, Feb 10, 2003 at 01:33:20PM -0800, David Schwartz wrote:

>>However, without the GPL, you already had the right to possess 
>>and
>>use the original work. Without the GPL, the distributor already had
>>the right to possess and use the original work and to create
>>derived
>>works. There is no issue of distribution rights to the original
>>work
>>because everyone involved started with the right to use and possess
>>the original work.

>I don't know which legal system you're baing the above on (USA?),
>but
>from my understanding of UK law (CDPA 1988,  as ammended),  it's
>different.

	Primarily USA, but I don't agree with your analysis of UK law.

>The acts of redistributing a work [ 16 (1)(b) ],  or adapting a work
>(i.e. derived work) [ 16 (1)(e)] are reserved,  and as such lacking
>some form of licence would constitute infringement.

>So given the above,  your argument would seem to fail wrt UK law.

	This neither says nor implies that the right to distribute the 
original work and the right to distribute derived works are unique 
rights to the original work. I claim they are not.

	I would go further and argue that with source code, there is no 
distinction between use and the the creation of derived works. The 
primary way you would use a header file is to include it in a project 
(thus creating a derived work). The primary way would use the GCC 
source code is to compile it (this creating a derived work).

	We *use* source code to create derived works and for no other 
primary purpose. So I would argue that for source code, there isn't a 
distinction between being able to use the work and being able to 
create derived works.

	I believe this is part of the reason the GPL talks about modifying 
rather than creating derived works. However, the term "modifying" is, 
as far as I know, not a legally precise one. Does compiling a program 
"modify" it? Does linking to a library "modify" it? I don't think 
anyone really knows. Section 2 tries to equate modification with 
creating derived works, but then you'd have to figure out how you 
could use the source code to the Linux kernel in the intended way 
without compiling it.

	The puzzling thing is the GPL refers to things like "the act of 
running the program", though it's not clear how you could run most 
programs without compiling them first. If compiling them is 
unrestricted, then so is creating derived works.

	IANAL, but I know that nobody knows the answer to these questions.

	DS


