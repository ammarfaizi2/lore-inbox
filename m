Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277115AbRJLAKi>; Thu, 11 Oct 2001 20:10:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277134AbRJLAK2>; Thu, 11 Oct 2001 20:10:28 -0400
Received: from mta05-svc.ntlworld.com ([62.253.162.45]:13532 "EHLO
	mta05-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id <S277115AbRJLAKW> convert rfc822-to-8bit; Thu, 11 Oct 2001 20:10:22 -0400
User-Agent: Microsoft-Outlook-Express-Macintosh-Edition/5.02.2022
Date: Fri, 12 Oct 2001 01:10:52 +0100
Subject: a thank you with a users notes 
From: jones <little.jones.family@ntlworld.com>
To: <linux-kernel@vger.kernel.org>
CC: <torvalds@transmeta.com>, <alan@lxorguk.ukuu.org.uk>,
        <rgooch@ras.ucalgary.ca>
Message-ID: <B7EBF39C.99AB%little.jones.family@ntlworld.com>
Mime-version: 1.0
Content-type: text/plain; charset="ISO-8859-1"
Content-transfer-encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all

I would like to thank you all for your efforts, whatever your motivation,
for the work on the kernel many call Linux. I appreciate it and use it to
write software.

I present here some of my observations and views. I have used many different
Linux distributions and compile my own kernel when I deem it appropriate (so
am I presume considered  a user of Linux). Also I add, I may NOT be
considered an expert in anything that I write about (below).

The Linux kernel has had quite good performance on many of the machines that
I have installed in on over the years. What concerns me is that whenever I
move  to a different architecture of CPU. Many other Operating Systems (OS)
are also able to operate between different architectures. This has, I think
kept the developers "honest" in so much as they have not provided
optimisations until the same structures and methods have been valid across
all of the OS "target" architectures. This could be seen in the development
of Windows NT where in addition to Intel Pentium the kernel had to work on
PowerPC and Alpha (I may be missing some but that¹s all I have used). This
same "honesty" was observed when I had to write software that would work on
ARM, SPARC and Intel Pentium. While I realise that, many developers have
only access to one architecture. It would seem prudent that Linux should be
tested more rigorously across different architectures.

Here are top architectures in my opinion (and remember they are only mine)

Intel Pentium (and derivatives from various vendors)
ARM 
SPARC
PowerPC
MIPS
There are many others but I consider the above to be in present in healthy
volumes within the global marketplace and have considerable investment going
into development of them(aparently).

The challenge for the Linux kernel that I have observed in my part of the
world is that components of computational systems (whatever their task) have
increasingly become "pull and plug" by which I mean that the users of these
systems pull out components and plug others in. Systems that I have used
before had to be given acknowledgement that this was going to happen or
would happen at a set time. I think (and believe me its dangerous) If I am
going to be able to use the kernel in the future I would have to be able to
also "pull and plug". I realise that this is a departure from the
traditional concepts of UNIX that are present within the Linux kernel but it
seem that many are also making this conclusion and even purposing solutions
(which is infinitely more useful than a users view). My only observation
about the "pull and plug" technology that surrounds me in my world is that
they all seem to be of 2 particular types. These types are IEE1394 (known as
fire wire or iLink ) or USB (version 1.1 and 2). These both adopt tree like
structures and identify themselves uniquely. Both seem to provide
information on their function and where there power source is.
So seem to be ideal for O/S integration. The sooner I may Pull and Plug on
my Linux system the better (for me not the plugs).

The above are just my ramblings attached to a letter of thanks for your hard
work over the years. The Linux kernel has been a joy to work with.

Regards

John Jones 

