Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129383AbRAXGxV>; Wed, 24 Jan 2001 01:53:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129401AbRAXGxL>; Wed, 24 Jan 2001 01:53:11 -0500
Received: from exit1.i-55.com ([204.27.97.1]:14302 "EHLO exit1.i-55.com")
	by vger.kernel.org with ESMTP id <S129445AbRAXGug>;
	Wed, 24 Jan 2001 01:50:36 -0500
Message-ID: <3A6E79EA.C2AD3806@mailhost.cs.rose-hulman.edu>
Date: Wed, 24 Jan 2001 00:44:58 -0600
From: Leslie Donaldson <donaldlf@hermes.cs.rose-hulman.edu>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0 alpha)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, donaldlf@hermes.cs.rose-hulman.edu
Subject: Question: Memory change request
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
  I realise this may be a little off topic but I think the kernel is the
only
place I will be able to pull this stunt.

I need a block of memory that can notify me or even a flag set when
it has been written to. I was thinking of letting the user code generate
some sort of page fault... Any random thoughts would be greatly
appreciated.

mmm ... Basically dirty page logic for user space....

Leslie Donaldson

-- 
/----------------------------\ Current Contractor: None
|    Leslie F. Donaldson     | Current Customer  : None
|    Computer Contractor     | Skills:
Unix/OS9/VMS/Linux/SUN-OS/C/C++/assembly
| Have Computer will travel. | WWW  :
http://www.cs.rose-hulman.edu/~donaldlf
\----------------------------/ Email: mail://donaldlf@cs.rose-hulman.edu
Goth Code V1.1: GoCS$$ TYg(T6,T9) B11Bk!^1 C6b-- P0(1,7) M+ a24 n---
b++:+
                H6'11" g m---- w+ r+++ D--~!% h+ s10 k+++ R-- Ssw
LusCA++
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
