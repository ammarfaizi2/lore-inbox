Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264531AbRFTSKQ>; Wed, 20 Jun 2001 14:10:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264537AbRFTSKF>; Wed, 20 Jun 2001 14:10:05 -0400
Received: from tangens.hometree.net ([212.34.181.34]:30160 "EHLO
	mail.hometree.net") by vger.kernel.org with ESMTP
	id <S264531AbRFTSJs>; Wed, 20 Jun 2001 14:09:48 -0400
To: linux-kernel@vger.kernel.org
Path: forge.intermeta.de!not-for-mail
From: "Henning P. Schmiedehausen" <mailgate@hometree.net>
Newsgroups: hometree.linux.kernel
Subject: Re: [OT] Threads, inelegance, and Java
Date: Wed, 20 Jun 2001 18:09:46 +0000 (UTC)
Organization: INTERMETA - Gesellschaft fuer Mehrwertdienste mbH
Message-ID: <9gqota$k36$1@forge.intermeta.de>
In-Reply-To: <9gponv$j92$1@forge.intermeta.de> <20010620042544.E24183@vitelus.com>
Reply-To: hps@intermeta.de
NNTP-Posting-Host: forge.intermeta.de
X-Trace: tangens.hometree.net 993060586 9462 212.34.181.4 (20 Jun 2001 18:09:46 GMT)
X-Complaints-To: news@intermeta.de
NNTP-Posting-Date: Wed, 20 Jun 2001 18:09:46 +0000 (UTC)
X-Copyright: (C) 1996-2001 Henning Schmiedehausen
X-No-Archive: yes
X-Newsreader: NN version 6.5.1 (NOV)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Aaron Lehmann <aaronl@vitelus.com> writes:

>On Wed, Jun 20, 2001 at 09:00:47AM +0000, Henning P. Schmiedehausen wrote:
>> Just the fact that some people use Java (or any other language) does
>> not mean, that they don't care about "performance, system-design or
>> any elegance whatsoever" [2].

>However, the very concept of Java encourages not caring about
>"performance, system-design or any elegance whatsoever". If you cared

Care to elaborate? It's an application programming language, not a
kernel hacker language, you know.

I won't call Java the perfect solution for everything, but it's an
useful tool for a certain type of applications.

>for a reason). Need run-anywhere support? Distribute sources instead.
>Once they are compiled they won't need to be reinterpreted on every
>run.

Thanks buddy. I've seen too many "#ifdef _SOLARIS_ || _LINUX &&
!_X86_" definition deserts to not wanting to do this again. Portability 
without os-specific tweaks for more than two or three platforms is a dream.

And most if not all commercial platforms don't come with perl, python,
tcl/tk or anything else installed. Many even without a (C-)compiler. 
Most without a C++-compiler.

	Regards
		Henning

-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen       -- Geschaeftsfuehrer
INTERMETA - Gesellschaft fuer Mehrwertdienste mbH     hps@intermeta.de

Am Schwabachgrund 22  Fon.: 09131 / 50654-0   info@intermeta.de
D-91054 Buckenhof     Fax.: 09131 / 50654-20   
