Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275265AbRJFQVQ>; Sat, 6 Oct 2001 12:21:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275278AbRJFQVF>; Sat, 6 Oct 2001 12:21:05 -0400
Received: from cc361913-a.flrtn1.occa.home.com ([24.0.193.171]:33679 "EHLO
	mirai.cx") by vger.kernel.org with ESMTP id <S275265AbRJFQVC>;
	Sat, 6 Oct 2001 12:21:02 -0400
Message-ID: <3BBF2F8C.7F3D72E1@pobox.com>
Date: Sat, 06 Oct 2001 09:21:32 -0700
From: J Sloan <jjs@pobox.com>
Organization: J S Concepts
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.11-pre3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.4.11-pre vs Red Hat, ac kernels
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been running 2.4.10 and 2.4.11-pre kernels on
my desktops at work and at home, am am generally
happy -

However, I have been doing some testing on a
Red Hat 7.1 box, a Compaq 6500 with 4 CPUs
and 1.2 GB RAM -

With any 2.4.11-pre kernel so far, the machine locks
up hard within seconds of starting a dbench run.
No log entries, and SysRq keys have no effect -
The power button is the only option in this case.

Just for giggles, I tried 2.4.10-ac6, which survived
a brutal round of dbench testing with no problems.

I also tried the roswell (2.4.7) and rawhide (2.4.9)
kernels from Red Hat, and they are both rock solid
as well in this testing.

more info on request -

cu

jjs

