Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268314AbTBYSAR>; Tue, 25 Feb 2003 13:00:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268315AbTBYSAR>; Tue, 25 Feb 2003 13:00:17 -0500
Received: from web13702.mail.yahoo.com ([216.136.175.135]:28941 "HELO
	web13702.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S268314AbTBYSAP>; Tue, 25 Feb 2003 13:00:15 -0500
Message-ID: <20030225181029.60365.qmail@web13702.mail.yahoo.com>
Date: Tue, 25 Feb 2003 10:10:29 -0800 (PST)
From: jalaja devi <jala_74@yahoo.com>
Subject: NTFS MetaData and Actual Data!
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
Please forgive me if i am posting to a wrong group as
I am new here. 

Trying to capture the DataStream where the Actual Data
is different from the NTFS Meta Data.

In detail, 
I  iSCSI running on top of a Storage Stack.
2. Winthrax is the host application.
3. Intel is the Initiator.

I see lot of Pattern match READ and WRITE Errors in
terms of Blocks. So trying to figure out the pattern
winthrax generates. 

2/24/2003, 16:56 Created compare thread ID: 1316
2/25/2003, 8:40 Compare error:
G:\winthrax\QA1069\SRC.8 vs.
H:\winthrax\QA1069\1636-2.dir\22791
.8
Line comparisons begin:
  Between Hex Offsets: a0000 and a003f
SRC:
000a0000->ABCDEFGHIJKLMNOPQRSTUVWXYZ.abcdefghijklmnopqrstuvwxyz
TRG:
000e0000->ABCDEFGHIJKLMNOPQRSTUVWXYZ.abcdefghijklmnopqrstuvwxyz
  Between Hex Offsets: a0040 and a007f
SRC:
000a0040->ABCDEFGHIJKLMNOPQRSTUVWXYZ.abcdefghijklmnopqrstuvwxyz
TRG:
000e0040->ABCDEFGHIJKLMNOPQRSTUVWXYZ.abcdefghijklmnopqrstuvwxyz
  Between Hex Offsets: a0080 and a00bf
SRC:
000a0080->ABCDEFGHIJKLMNOPQRSTUVWXYZ.abcdefghijklmnopqrstuvwxyz
TRG:
000e0080->ABCDEFGHIJKLMNOPQRSTUVWXYZ.abcdefghijklmnopqrstuvwxyz
  Between Hex Offsets: a00c0 and a00ff
SRC:
000a00c0->ABCDEFGHIJKLMNOPQRSTUVWXYZ.abcdefghijklmnopqrstuvwxyz
TRG:
000e00c0->ABCDEFGHIJKLMNOPQRSTUVWXYZ.abcdefghijklmnopqrstuvwxyz
  Between Hex Offsets: a0100 and a013f


Is there a way to differntiate between the MetaDAta
and the ActualData?

Thanks/Sorry




__________________________________________________
Do you Yahoo!?
Yahoo! Tax Center - forms, calculators, tips, more
http://taxes.yahoo.com/
