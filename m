Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132914AbRDEOlU>; Thu, 5 Apr 2001 10:41:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132912AbRDEOlQ>; Thu, 5 Apr 2001 10:41:16 -0400
Received: from web12406.mail.yahoo.com ([216.136.173.133]:17421 "HELO
	web12406.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S132913AbRDEOjy>; Thu, 5 Apr 2001 10:39:54 -0400
Message-ID: <20010405143912.86227.qmail@web12406.mail.yahoo.com>
Date: Thu, 5 Apr 2001 07:39:12 -0700 (PDT)
From: Laura Dean <tralad@yahoo.com>
Subject: compile error - ldmxcsr
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


When I try to compile the linux 2.4.2 kernel I am
getting the following error:

{standard input}: Assembler messages:
{standard input}:30: Error: no such 386 instruction:
`ldmxcsr' 

It looks like an old assembler, but I am using
binutils 2.10 and have also tried binutils 2.10.1.  I
am using   egcs-2.91.66 as my compiler.
 
I am running Caldera OpenLinux 2.3, which uses
glibc-2.1.1-1, which I know is kind of an old version
and I am wondering if this could be the problem? Any
other ideas as to what could cause this? Thanks in
advance for any help or advice.

Laura

__________________________________________________
Do You Yahoo!?
Get email at your own domain with Yahoo! Mail. 
http://personal.mail.yahoo.com/
