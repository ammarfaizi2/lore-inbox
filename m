Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288535AbSAHWur>; Tue, 8 Jan 2002 17:50:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288534AbSAHWui>; Tue, 8 Jan 2002 17:50:38 -0500
Received: from dorf.wh.uni-dortmund.de ([129.217.255.136]:24844 "HELO
	mail.dorf.wh.uni-dortmund.de") by vger.kernel.org with SMTP
	id <S288564AbSAHWu0>; Tue, 8 Jan 2002 17:50:26 -0500
Date: Tue, 8 Jan 2002 23:49:58 +0100
From: Patrick Mau <mau@oscar.prima.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Still linker errors in 2.5.2-pre10
Message-ID: <20020108224958.GA8594@oscar.dorf.de>
Reply-To: Patrick Mau <mau@oscar.prima.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I'm still unable to build 2.5.2-pre10 because of binutils
stricter symbol handling.

Finding objects, 521 objects, ignoring 0 module(s)
Finding conglomerates, ignoring 50 conglomerate(s)
Scanning objects
Error: ./drivers/char/serial.o .data refers to 000030d4 R_386_32 .text.exit
Error: ./drivers/net/eepro100.o .data refers to 000000d4 R_386_32 .text.exit
Done

cheers,
Patrick
