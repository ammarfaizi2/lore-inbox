Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264851AbSJVT51>; Tue, 22 Oct 2002 15:57:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264837AbSJVT4Z>; Tue, 22 Oct 2002 15:56:25 -0400
Received: from email.gcom.com ([206.221.230.194]:7332 "EHLO gcom.com")
	by vger.kernel.org with ESMTP id <S264835AbSJVT4E>;
	Tue, 22 Oct 2002 15:56:04 -0400
Message-Id: <5.1.0.14.2.20021022145759.02861ec8@localhost>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Tue, 22 Oct 2002 15:01:47 -0500
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From: David Grothe <dave@gcom.com>
Subject: I386 cli
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In 2.5.41every architecture except Intel 386 has a "#define cli 
<something>" in its asm-arch/system.h file.  Is there supposed to be such a 
define in asm-i386/system.h?  If not, where does the "official" definition 
of cli() live for Intel?  Or what is the include file that one needs to 
pick it up?  I can't find it.
Thanks,
Dave

