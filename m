Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280861AbRKGQwX>; Wed, 7 Nov 2001 11:52:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280859AbRKGQwN>; Wed, 7 Nov 2001 11:52:13 -0500
Received: from web13105.mail.yahoo.com ([216.136.174.150]:13321 "HELO
	web13105.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S280853AbRKGQvy>; Wed, 7 Nov 2001 11:51:54 -0500
Message-ID: <20011107165153.91027.qmail@web13105.mail.yahoo.com>
Date: Wed, 7 Nov 2001 08:51:53 -0800 (PST)
From: szonyi calin <caszonyi@yahoo.com>
Subject: Q:Howto benchmark preemptible kernel ?
To: linux-kernel@vger.kernel.org
Cc: akpm@zip.com.au, rml@tech9.net
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi 
I'm have a Cyrix 486/66 with 12Megs of ram.
I'm using preemptible patches from quite some time
now.
(2.4.10- 2.4.13)
I was using both Robert Love and Andrew Morton's
patch.
I would like to do some benhmarks but there are some
issues:
1. The system is slow and has low memory so a big
benchmark is out of question (compiling the kernel
take 4 hours if i don't touch the console)
2. The benchmark must be small and adequate (patching
the kernel to make a benchmark is out of discussion)

Any ideas ?

(No i don't have money to buy a new machine, I win
200$/month, a new pc (crappy) is 350-400$ (in my
country)).

I did run (some time ago, without preemptible kernel)
some benchmarks (bonnie, and bytebench or something)
but it was no improvement (1% maybe ) whatever I have
done with hdparm or vm tweaking.
 
P.S. (for Andrew ) Will there be a patch for 2.4.14 ?


__________________________________________________
Do You Yahoo!?
Find a job, post your resume.
http://careers.yahoo.com
