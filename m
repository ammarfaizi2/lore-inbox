Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262069AbSJNT61>; Mon, 14 Oct 2002 15:58:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262136AbSJNT61>; Mon, 14 Oct 2002 15:58:27 -0400
Received: from tesla.eecs.ku.edu ([129.237.87.2]:3851 "EHLO tesla.eecs.ku.edu")
	by vger.kernel.org with ESMTP id <S262069AbSJNT60>;
	Mon, 14 Oct 2002 15:58:26 -0400
Date: Mon, 14 Oct 2002 15:04:19 -0500 (CDT)
From: Gayathri Chandrasekaran <gchandra@eecs.ku.edu>
To: linux-kernel@vger.kernel.org
Subject: accessing the program counter
Message-ID: <20021014143728.U98244-100000@tesla.eecs.ku.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello
I'm trying to read the value of program counter at the time a context
switch occurs from the kernel.I looked at the schedule() function in
sched.c and also the switch_to() in system.h.I also looked at the
current_text_addr () in include/asm-i386/processor.h which is a macro that
returns the current instruction pointer.But I'm nto sure if I'm in the
right track.Also I need some help in understanding the assmbly language
instructions.Can someone help me with this.

thanks
gayathri

Gayathri Chandrasekaran
Department of Electrical
Engineering and Computer Science
University of Kansas
Lawrence,KS-66045.

