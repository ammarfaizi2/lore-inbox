Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264570AbRFTTFt>; Wed, 20 Jun 2001 15:05:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264572AbRFTTFk>; Wed, 20 Jun 2001 15:05:40 -0400
Received: from c266492-a.lakwod1.co.home.com ([24.1.8.253]:3338 "EHLO
	benatar.snurgle.org") by vger.kernel.org with ESMTP
	id <S264570AbRFTTFa>; Wed, 20 Jun 2001 15:05:30 -0400
Date: Wed, 20 Jun 2001 15:05:06 -0400 (EDT)
From: William T Wilson <fluffy@snurgle.org>
To: Aaron Lehmann <aaronl@vitelus.com>
cc: hps@intermeta.de, linux-kernel@vger.kernel.org
Subject: Re: [OT] Threads, inelegance, and Java
In-Reply-To: <20010620042544.E24183@vitelus.com>
Message-ID: <Pine.LNX.4.21.0106201451580.2366-100000@benatar.snurgle.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Jun 2001, Aaron Lehmann wrote:

> However, the very concept of Java encourages not caring about
> "performance, system-design or any elegance whatsoever". If you cared
> about any of those things you would compile to native code (it exists

Native code does not help performance much and it doesn't help elegance or
system design at all.

Programmers put incredible amounts of effort into design with C-related
languages because they have to.  If they don't their program will not
work.  Java makes it easy to write bad code that (mostly) works.  This
might mean that the average quality of Java code is not as good as it
might be.  But it's not a good reason not to write in Java.

Programmers that put the same amount of effort into their Java code that
they would have in C/C++ will write better programs faster than they would
have in C.  The fact that most programmers will not do this is not the
fault of the language, but the programmers.

> for a reason). Need run-anywhere support? Distribute sources instead.

Distributing source gives you run-anywhere support provided that everyone
you distribute to has the same compiler that you do and that you haven't
missed any platform specific endianness, word size or type definition
problems, and that your program doesn't require any I/O that isn't in the
standard libraries, especially graphics.

