Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267747AbTBGJHe>; Fri, 7 Feb 2003 04:07:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267748AbTBGJHe>; Fri, 7 Feb 2003 04:07:34 -0500
Received: from [202.131.133.36] ([202.131.133.36]:36817 "EHLO mail.kongu.ac.in")
	by vger.kernel.org with ESMTP id <S267747AbTBGJHd>;
	Fri, 7 Feb 2003 04:07:33 -0500
From: "Arvind Kalyan" <arvy@kongu.ac.in>
To: linux-kernel@vger.kernel.org
Subject: kernel oops on ifconfig
Date: Fri, 7 Feb 2003 14:17:19 +0530
Message-Id: <20030207141719.M50715@mail.kongu.ac.in>
X-Mailer: KEC Web Mail 1.0 01-02-2002
X-OriginatingIP: 172.16.7.3 (arvy)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
the error we got when we ran ifconfig on a ppc (imac machine). the kernel 
version has also been included.. 
 
please send CC to arvind@kongu.edu 
 
[2JLinux KONGU.ITP7-3 2.4.19-4a #1 Wed Jun 5 01:34:59 EDT 2002 ppc unknown 
Oops: kernel access of bad area, sig: 11 
NIP: 00000000 XER: 20000000 LR: D5B166DC SP: C41BDEA0 REGS: c41bddf0 TRAP: 
0400    Not tainted 
MSR: 40009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11 
TASK = c41bc000[4078] 'ifconfig' Last syscall: 6  
last math c41bc000 last altivec 00000000 
GPR00: 00000000 C41BDEA0 C41BC000 CD48F880 CC3D6940 00000000 CC3D6940 
CB7D2100  
GPR08: C41C4ED0 00000000 00000000 CD48F880 40000088 10027A64 00000000 
10020000  
GPR16: 00000000 00000000 00000000 00000000 00009032 041BDF40 00000000 
C0006418  
GPR24: C0006180 1000CCA0 300252CC 0FFEA718 C3324EC0 CD48F880 C41C4DA0 
C41C4EC0  
Call backtrace:  
CCFF7000 C0237A38 C023801C C003FA4C C003E4BC C003E554 C00061DC  
10001A48 0FECEF70 00000000  
 
 
Thank you. 
 
Arvind Kalyan 
___________________________________________________
Kongu Engineering College - Assuring the Best!!!
http://kongu.ac.in, http://kongu.edu

