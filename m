Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265537AbRF2E70>; Fri, 29 Jun 2001 00:59:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265542AbRF2E7P>; Fri, 29 Jun 2001 00:59:15 -0400
Received: from nwcst31g.netaddress.usa.net ([204.68.23.62]:60377 "HELO
	nwcst317.netaddress.usa.net") by vger.kernel.org with SMTP
	id <S265537AbRF2E7B> convert rfc822-to-8bit; Fri, 29 Jun 2001 00:59:01 -0400
Message-ID: <20010629045900.23639.qmail@nwcst317.netaddress.usa.net>
Date: 28 Jun 2001 22:59:00 MDT
From: Blesson Paul <blessonpaul@usa.net>
To: linux-kernel@vger.kernel.org
Subject: gcc: internal compiler error: program cc1 got fatal signal 11
X-Mailer: USANET web-mailer (34FM.0700.17C.01)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi
                  I am trying to compile the kernel2.4.5 source code. 
Presently I have kernel2.2.14 and Redhat6.2. I have egcs1.2.2.  Now when I
compile I will get the following error 
 gcc: Internel compiler error: program 	 cc1 got fatal signal 11
 make Error 1
 Leaving directory ...
 ..........
 .............
 Assembler messages 
 Warning: end of file not at end of file: newline inserted 
 cpp: output pipe has been closed 
  Error: suffix or operands invalid for mov   
		Here  cofusion part is that, when I recompile, the same part where this
error occured will compile perfectly. But again after some compilation, the
same error will show in any other place. The last line in the error statement
may be different in the second time.                   
 
                           Moreover my cpu info in given below. I have given
processor i486. Is there any particular choice should be made to compile
kernel source code
                         
processor	: 0
vendor_id	: AuthenticAMD
cpu family	: 5
model		: 8
model name	: AMD-K6(tm) 3D processor
stepping	: 12
cpu MHz		: 400.921117
fdiv_bug	: no
hlt_bug		: no
sep_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr mce cx8 sep mtrr pge mmx 3dnow
bogomips	: 799.54

