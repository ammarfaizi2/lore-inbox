Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130315AbQLNJHm>; Thu, 14 Dec 2000 04:07:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130638AbQLNJHc>; Thu, 14 Dec 2000 04:07:32 -0500
Received: from linux.kappa.ro ([194.102.255.131]:52486 "EHLO linux.kappa.ro")
	by vger.kernel.org with ESMTP id <S130315AbQLNJHQ>;
	Thu, 14 Dec 2000 04:07:16 -0500
Date: Thu, 14 Dec 2000 10:21:45 +0200
From: Mircea Damian <dmircea@linux.kappa.ro>
To: linux-kernel@vger.kernel.org
Subject: do NOT compile 2.2.18 with egcs-1.1.2
Message-ID: <20001214102145.B17934@linux.kappa.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

I just want to let other know that kernel 2.2.18 does not work properly (*)
on my box if I compile it with egcs-2.91.66 19990314/Linux (egcs-1.1.2
release). Instead gcc-2.7.2.3 works ok.

(*) the network driver PCI NE2000 does not work with all three cards. It
just sees them but they do not work.

-- 
Mircea Damian
E-mails: dmircea@kappa.ro, dmircea@roedu.net
WebPage: http://taz.mania.k.ro/~dmircea/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
