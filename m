Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314029AbSDLOa5>; Fri, 12 Apr 2002 10:30:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314031AbSDLOa4>; Fri, 12 Apr 2002 10:30:56 -0400
Received: from h108-129-61.datawire.net ([207.61.129.108]:10757 "HELO
	mail.datawire.net") by vger.kernel.org with SMTP id <S314029AbSDLOaz>;
	Fri, 12 Apr 2002 10:30:55 -0400
Subject: Kernel panic 2.4.19-pre6 AND 2.4.19-pre5-ac3 - More info - ksymoops
From: Shawn Starr <shawn.starr@datawire.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.2.99 Preview Release
Date: 12 Apr 2002 09:36:28 -0400
Message-Id: <1018618588.224.15.camel@unaropia>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Code: 8b 40 20 c7 40 24 00 00 00 00 a1 a0 3e 2d c0 59 89 15 c4 cf
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   8b 40 20                  mov    0x20(%eax),%eax
Code;  00000003 Before first symbol
   3:   c7 40 24 00 00 00 00      movl   $0x0,0x24(%eax)
Code;  0000000a Before first symbol
   a:   a1 a0 3e 2d c0            mov    0xc02d3ea0,%eax
Code;  0000000f Before first symbol
   f:   59                        pop    %ecx
Code;  00000010 Before first symbol
  10:   89 15 c4 cf 00 00         mov    %edx,0xcfc4

-- 
Shawn Starr
Developer Support Engineer
Datawire Communication Networks Inc.
10 Carlson Court, Suite 300
Toronto, ON, M9W 6L2
T: 416-213-2001 ext 179  F: 416-213-2008

