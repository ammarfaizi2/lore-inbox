Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267427AbTAVLVn>; Wed, 22 Jan 2003 06:21:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267434AbTAVLVn>; Wed, 22 Jan 2003 06:21:43 -0500
Received: from web14707.mail.yahoo.com ([216.136.224.124]:13572 "HELO
	web14707.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S267427AbTAVLVm>; Wed, 22 Jan 2003 06:21:42 -0500
Message-ID: <20030122113050.65639.qmail@web14707.mail.yahoo.com>
Date: Wed, 22 Jan 2003 03:30:50 -0800 (PST)
From: Electroniks New <elektr_new@yahoo.com>
Subject: sleep in asm
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  What is the equivalent of sleep in assembly.
  I tried jmps and nops i even kept loops.for jumps
and nops but all in vain .
  Does it make any difference if i am doing this real
mode instead of pmode ? doesnt the functions nop and
jmps   do what they are supposed to do . 16000 nops
doesn't sleep for 1 sec.

Any help would be appreciated. 

__________________________________________________
Do you Yahoo!?
Yahoo! Mail Plus - Powerful. Affordable. Sign up now.
http://mailplus.yahoo.com
