Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265243AbTLFUbb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Dec 2003 15:31:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265246AbTLFUbb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Dec 2003 15:31:31 -0500
Received: from smtp05.web.de ([217.72.192.209]:55576 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id S265243AbTLFUba (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Dec 2003 15:31:30 -0500
Subject: Re: 2.6.0-preX causes memory corruption
From: Ali Akcaagac <aliakc@web.de>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1070742702.1735.4.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 06 Dec 2003 21:31:42 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Around 2 weeks ago I made a bugreport about strange memory corruption
which have occoured with Kernel 2.6.0-pre9/10 on my system. As I told I
verified this problem on 2 different machines and today I wanted to give
feedback as I promised.

I was busy with private stuff for a couple of days and wasn't able to
check this any closer. Today I detected that even with PREEMPT DISABLED
in 2.6.0-pre11 the problem still exists. E.g. when unpacking some
tar.bz2 files I still get the message thrown out that there is a problem
and after reset the problem is gone. As reference I give you my previous
email to this list:

http://www.ussg.iu.edu/hypermail/linux/kernel/0311.3/0386.html

And another one which I think may (or may not) be related to this:

http://www.ussg.iu.edu/hypermail/linux/kernel/0311.3/0122.html

Again, this has problem exists on my old hardware as on my brand new
hardware. So basically 2 different plattforms.

Please CC to me.

