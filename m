Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261573AbSLHVUk>; Sun, 8 Dec 2002 16:20:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261594AbSLHVUk>; Sun, 8 Dec 2002 16:20:40 -0500
Received: from sccrmhc01.attbi.com ([204.127.202.61]:58587 "EHLO
	sccrmhc01.attbi.com") by vger.kernel.org with ESMTP
	id <S261573AbSLHVUk> convert rfc822-to-8bit; Sun, 8 Dec 2002 16:20:40 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Matt Young <wz6b@arrl.net>
Reply-To: wz6b@arrl.net
To: linux-kernel@vger.kernel.org
Subject: 2.5.50. input_event      undefined --- any ideas 
Date: Sun, 8 Dec 2002 13:27:48 -0800
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200212081327.48723.wz6b@arrl.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/built-in.o: In function `kd_nosound':
drivers/built-in.o(.text+0x38bca): undefined reference to `input_event'
drivers/built-in.o(.text+0x38bdd): undefined reference to `input_event'


also. what was the solution for --- 

rch/i386/kernel/built-in.o: In function `do_suspend_lowlevel':
arch/i386/kernel/built-in.o(.data+0x14d8): undefined reference to 
`save_processor_state'
arch/i386/kernel/built-in.o(.data+0x14de): undefined reference to 
`saved_context_esp'
arch/i386/kernel/built-in.o(.data+0x14e3): undefined reference to 
`saved_context_eax'
arch/i386/kernel/built-in.o(.data+0x14e9): undefined reference to 
`saved_context

