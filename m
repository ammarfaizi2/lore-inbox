Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262944AbTJECYb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Oct 2003 22:24:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262948AbTJECYb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Oct 2003 22:24:31 -0400
Received: from eleanor.physics.ucsb.edu ([128.111.8.116]:9644 "EHLO
	eleanor.physics.ucsb.edu") by vger.kernel.org with ESMTP
	id S262944AbTJECYa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Oct 2003 22:24:30 -0400
Date: Sat, 4 Oct 2003 19:25:08 -0700 (PDT)
From: David Whysong <dwhysong@physics.ucsb.edu>
To: <linux-kernel@vger.kernel.org>
Subject: MCE non fatal errors on an opteron CPU (fwd)
Message-ID: <Pine.LNX.4.33.0310041924420.5264-100000@eleanor.physics.ucsb.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I'm getting these messages every 15 seconds. Can someone tell me what this
means?

Oct  2 15:55:35 sleepy kernel: MCE: The hardware reports a non fatal,
correctable incident occurred on CPU 1.
Oct  2 15:55:35 sleepy kernel: Bank 0: c408400000000833
Oct  2 15:55:36 sleepy kernel: MCE: The hardware reports a non fatal,
correctable incident occurred on CPU 1.
Oct  2 15:55:36 sleepy kernel: Bank 1: d400400000000853
Oct  2 15:55:36 sleepy kernel: MCE: The hardware reports a non fatal,
correctable incident occurred on CPU 1.
Oct  2 15:55:36 sleepy kernel: Bank 2: d400400000000813
Oct  2 15:55:36 sleepy kernel: MCE: The hardware reports a non fatal,
correctable incident occurred on CPU 1.
Oct  2 15:55:36 sleepy kernel: Bank 4: 9408400100000813


-- 
David Whysong                                       dwhysong@physics.ucsb.edu
Astrophysics graduate student         University of California, Santa Barbara
My public PGP keys are on my web page - http://www.physics.ucsb.edu/~dwhysong
DSS PGP Key 0x903F5BD6  :  FE78 91FE 4508 106F 7C88  1706 B792 6995 903F 5BD6
D-H PGP key 0x5DAB0F91  :  BC33 0F36 FCCD E72C 441F  663A 72ED 7FB7 5DAB 0F91

