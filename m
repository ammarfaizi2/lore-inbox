Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130199AbRBPQMd>; Fri, 16 Feb 2001 11:12:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130489AbRBPQMX>; Fri, 16 Feb 2001 11:12:23 -0500
Received: from [216.102.244.21] ([216.102.244.21]:41999 "EHLO mail1.BZZNET.NET")
	by vger.kernel.org with ESMTP id <S130199AbRBPQMM>;
	Fri, 16 Feb 2001 11:12:12 -0500
Message-ID: <FF2E85D46133D3119868006008AC264808D0FBDC@MAIL1>
From: fsnchzjr <fsnchzjr@zxmail.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Little question of mine....
Date: Fri, 16 Feb 2001 08:10:44 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please excuse my newbie question...
I've been fooling around with module programing on 2.4.0, and I've made this
little module for a char device that printk's (darn, my kernel log's growing
real huge now!!!) anything I redirect into /dev/charmod (Hurray! I made my
first module).... I have not yet implemented any read facilities, yet....
and here's my question: What's IOCTL? What do I need it for?

Oh BTW, I have this dumb little idea (please flame me if it's stupid...)...
Here goes: I want to create a small database system (possibly using
ANSI-SQL92??) that's integrated into the kernel... I think I'd make a module
for a char device, which would be used for comm' with the database and a
module for a filesystem (which I'd have to come up with) that would hold the
database... Do any of you think such a database would be faster than other
database systems? 
Please tell me what you people think about this...

PS. a big thanks to Mr. Wolff for starting me up on file_operations...
