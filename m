Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268992AbTBWWaf>; Sun, 23 Feb 2003 17:30:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269002AbTBWWaf>; Sun, 23 Feb 2003 17:30:35 -0500
Received: from palrel12.hp.com ([156.153.255.237]:49057 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id <S268992AbTBWWae>;
	Sun, 23 Feb 2003 17:30:34 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15961.19948.882374.766245@napali.hpl.hp.com>
Date: Sun, 23 Feb 2003 14:40:44 -0800
To: Linus Torvalds <torvalds@transmeta.com>
Cc: davidm@hpl.hp.com, linux-kernel@vger.kernel.org
Subject: Re: Minutes from Feb 21 LSE Call
In-Reply-To: <Pine.LNX.4.44.0302231326370.1534-100000@home.transmeta.com>
References: <15961.8482.577861.679601@napali.hpl.hp.com>
	<Pine.LNX.4.44.0302231326370.1534-100000@home.transmeta.com>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Sun, 23 Feb 2003 13:34:32 -0800 (PST), Linus Torvalds <torvalds@transmeta.com> said:

 Linus> Last I saw P4 was kicking ia-64 butt on specint and friends.

I don't think so.  According to Intel [1], the highest clockfrequency
for a 0.18um part is 2GHz (both for Xeon and P4, for Xeon MP it's
1.5GHz).  The highest reported SPECint for a 2GHz Xeon seems to be 701
[2].  In comparison, a 1GHz McKinley gets a SPECint of 810 [3].

	--david

[1] http://www.intel.com/support/processors/xeon/corespeeds.htm
[2] http://www.specbench.org/cpu2000/results/res2002q1/cpu2000-20020128-01232.html
[3] http://www.specbench.org/cpu2000/results/res2002q3/cpu2000-20020711-01469.html
