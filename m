Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263764AbTLEAJS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 19:09:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263760AbTLEAJS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 19:09:18 -0500
Received: from cantva.canterbury.ac.nz ([132.181.2.27]:14097 "EHLO
	cantva.canterbury.ac.nz") by vger.kernel.org with ESMTP
	id S263764AbTLEAJG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 19:09:06 -0500
Date: Fri, 05 Dec 2003 13:09:00 +1300
From: Oliver Hunt <ojh16@student.canterbury.ac.nz>
Subject: Re: Linux GPL and binary module exception clause?
In-reply-to: <20031204235055.62846.qmail@web21503.mail.yahoo.com>
To: Paul Adams <padamsdev@yahoo.com>, linux-kernel@vger.kernel.org
Message-id: <3FCFCC9C.8030901@student.canterbury.ac.nz>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (Macintosh; U; PPC Mac OS X Mach-O; en-US; rv:1.5b)
 Gecko/20030727 Thunderbird/0.1
References: <20031204235055.62846.qmail@web21503.mail.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Paul Adams wrote:

> --- In linux-kernel@yahoogroups.com, Linus Torvalds
> <torvalds@o...> wrote:
> 
>>- anything that was written with Linux in mind
> 
> (whether it then
> 
>>_also_ works on other operating systems or not) is
> 
> clearly
> 
>>partially a derived work.
> 
> 
> I am no more a lawyer than you are, but I have to
> disagree.  You
> are not free to define "derivative work" as you
> please.  You
> must use accepted legal definitions.  At least in the
> U.S., you
> must consider what Congress had to say on this.  They
> said, "to
> constitute a violation of section 106(2) [which gives
> copyright
> owners rights over derivative works], the infringing
> work must
> incorporate a portion of the copyrighted work in some
> form; for
> example, a detailed commentary on a work or a
> programmatic musical
> composition inspired by a novel would not normally
> constitute
> infringements under this clause."
> http://www4.law.cornell.edu/uscode/17/106.notes.html
> 
> A work that is inspired by Linux is no more a
> derivative work than
> a programmatic musical composition inspired by a
> novel.  Having
> Linux in mind cannot be enough to constitute
> infringement.
> 
> Remember also that U.S. copyright law states:
> "In no case does copyright protection for an original
> work of
> authorship extend to any idea, procedure, process,
> system, method
> of operation, concept, principle, or discovery,
> regardless of
> the form in which it is described, explained,
> illustrated, or
> embodied in such work."
> http://www4.law.cornell.edu/uscode/17/102.html
> Thus you cannot claim infringement because a work
> merely shares
> ideas or methods of operation with Linux.
> 
> The standard used in U.S. courts for determining if
> software
> violates a copyright includes a filtering procedure to
> eliminate
> unprotected aspects as described above.  A standard
> filter is that
> you eliminate an element if "The element's expression
> was dictated
> by external factors, such as using an existing file
> format or
> interoperating with another program."  Computer
> Associates v.
> Altai specifically discusses the need to filter
> elements related
> to "compatibility requirements of other programs with
> which a
> program is designed to operate in conjunction."
> http://www.bitlaw.com/source/cases/copyright/altai.html
> Code needed to interoperate with the Linux kernel thus
> cannot be
> considered as a factor in determining if the Linux
> copyright is
> infringed.
> 
> Unless actual Linux code is incorporated in a binary
> distribution
> in some form, I don't see how you can claim
> infringement of the
> copyright on Linux code, at least in the U.S.
> 
> 
> 
> __________________________________
> Do you Yahoo!?
> Free Pop-Up Blocker - Get it now
> http://companion.yahoo.com/
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

Yes, but the if you want to write a kernel modules you need to #include
at least a few of the headers: you are including copyrighted work...

What (i think) linus is saying is that he, as the owner of the 
copyright, would accept a ported driver as not being derived(as most of 
the work would have been based on another system, not linux), but that 
is his choice, he is allowed to relax the terms of use because it is his 
copyright...

I'm not however ever a lawyer...

--Oliver
The Department Formerly Known as Cosc
University of Canterbury
New Zealand


