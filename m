Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265102AbTBKTaO>; Tue, 11 Feb 2003 14:30:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265081AbTBKTaO>; Tue, 11 Feb 2003 14:30:14 -0500
Received: from mail.webmaster.com ([216.152.64.131]:15760 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S265058AbTBKTaN> convert rfc822-to-8bit; Tue, 11 Feb 2003 14:30:13 -0500
From: David Schwartz <davids@webmaster.com>
To: <brand@jupiter.cs.uni-dortmund.de>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Mailer: PocoMail 2.63 (1077) - Licensed Version
Date: Tue, 11 Feb 2003 11:39:57 -0800
In-Reply-To: <200302110742.h1B7gQqE011999@eeyore.valparaiso.cl>
Subject: Re: Monta Vista software license terms
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-ID: <20030211193959.AAA14852@shell.webmaster.com@whenever>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Feb 2003 08:42:26 +0100, Horst von Brand wrote:

>>On Mon, 10 Feb 2003 11:42:45 -0600, Oliver Xymoron wrote:

>>>I certainly agree, but the problem is the NDA puts the shoe on the
>>>other foot and now it's the customer that has to consult a lawyer
>>>or
>>>risk a nuisance suit before proceeding. So while it may not
>>>forbid, >it
>>>certainly discourages and impedes. Let me point out that I never
>>>saw
>>>the NDA in question but said coworker was sufficiently intimidated
>>>>by
>>>it that he was unwilling to give me a copy of the kernel and gcc
>>>sources because of it.

>>    I believe such a provision would, unfortunately, by considered
>>legally enforceable. The rationale would be that the rights you
>>(the
>>recipient of the derived work) have under the GPL would only apply
>>if
>>the distributor were bound by the GPL. The only way the distributor
>>
>>could be bound by the GPL was if he or she did something that he
>>didn't have the right to do without the GPL to give him or her such
>>a
>>right.

>The GPL gives me the right to distribute modified versions _only if 
>I
>comply with the GPL_. And GPL forbids further restrictions when
>distributing.

	I realize that. But that has nothing to do with what I said, which 
analyzes only those rights you have without agreeing to the GPL by 
virtue of the fact that you possess the work and were not subject to 
any restrictions in the process of acquiring and using it.

>If your bizarre interpretation was right, no software licence at all
>would
>have any validity. In particular, I'd be more than very surprised if
>the
>GPL was so sloppily written. It was written with the input of 
>eminent lawyers, after all.

	Your generalization doesn't apply because of several major 
differences between most software licenses and the GPL:

	1) Most software licenses do not grant everyone the right to use the 
work covered.

	2) Most software licenses do not grant anyone the right to create 
derived works.

	3) Most software licenses require your assent before you can use the 
covered work, in fact, most require your assent before you have the 
right to possess the covered work.

	However, one sticky point is that the GPL talks about 'modifying' a 
work. You can create derived works without modifying the original 
work and the GPL is unclear in this respect. However, I would argue 
that linking to a library file is using it and including a header 
file in your C code is using it. After all, there is nothing else you 
can do with such files.

	DS


