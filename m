Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267156AbTAUSdA>; Tue, 21 Jan 2003 13:33:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267157AbTAUSdA>; Tue, 21 Jan 2003 13:33:00 -0500
Received: from web14705.mail.yahoo.com ([216.136.224.122]:12817 "HELO
	web14705.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S267156AbTAUSc6>; Tue, 21 Jan 2003 13:32:58 -0500
Message-ID: <20030121184202.44314.qmail@web14705.mail.yahoo.com>
Date: Tue, 21 Jan 2003 10:42:02 -0800 (PST)
From: Electroniks New <elektr_new@yahoo.com>
Subject: Bios interrupts
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  1) i don't exactly understand the ports (Bios data).
   I also understand that linux does override the bios
   functions so that more functionality is acheived.

  2) Can you send the standard ports for use and i may
later use inb and 
     oub on  those ports for data exchange.
 
  3) Also what does jmp short $+2 instruction do ?How
can i change it into   AT&T syntax or inline assembly
? Also what does instruction "in al,64h" do .
   I found these on the net.They are dos code i
assume. Is "in" same as mov .
   If not how do they differ ?  The article was named
Enabling the A20 line.
  (never mind the article).
   It somewhere says enable  .
   Any idea where can i change into AT&T syntax.It is
in Intel syntax. 
  Any idea of sleep instruction in assembly. I tried
but couldn't find .
    I tried a couple of jmps but it never slows down
.How to make the pc sleep 
    (asm instruction for sleep (CPU idle).I put 16000
jmps loops but didn't 
    slow down a bit . 
 
  4) If possible please explain how to use keyboard in
a similar manner.
   (If time permits then simple mouse code).
  
   5)I don't understand the keyboard interrupts 0x64 ,
mouse 0x33 and in some 
    sites  i see the keyboard controllers as 0x64
where as in some sites the 
     code contains  0x10.So what should i use in my
program.
 
  6) Is there any documentation for these ports to
read and write data.


__________________________________________________
Do you Yahoo!?
Yahoo! Mail Plus - Powerful. Affordable. Sign up now.
http://mailplus.yahoo.com
