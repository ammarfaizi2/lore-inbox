Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269194AbTGOTU4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 15:20:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269506AbTGOTU4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 15:20:56 -0400
Received: from air-2.osdl.org ([65.172.181.6]:52917 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269194AbTGOTUq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 15:20:46 -0400
Message-Id: <200307151935.h6FJZak09872@mail.osdl.org>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: linux-kernel@vger.kernel.org
cc: kernelnewbies@nl.linux.org
Subject: [STP] stp 2.1.0 escapes, re-aim re-announce, results
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 15 Jul 2003 12:35:36 -0700
From: Cliff White <cliffw@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Several items in one email, more text than data, sorry. 
We've done an update of the Scalable Test Platform code, (rev 2.1.0)
 added a BK repo in addition to Sourceforge CVS, _we think STP is much better 
now.
The email to the test requestors is much improved, especially when the
kernel fails, and the results are more complete.

If you've tried us in the past, give it another go, send your cards, letters 
and
complaints on in. Also, any suggestions for new tests are most appreciated. 

Speaking of new tests, the AIM 7/9 rework, "reaim" is now running on STP and
code bundles are available. I hope to actually finish working on the code 
sometime
after OLS, please send patches/complaints to me.

There is a comparison graph and reports on 7 recent kernels at:
http://www.osdl.org/archive/cliffw/reaim/index.html 
We are looking for some better ways of doing results via email. The reaim test
does produce lovely graphs, (if i do say so myself)
 which is why i'm sending pointers to Web pages.

We're talking about a magic-results-diff generator on 
stp-devel@lists.sourceforge.net,
please join the agru^H^H^H^H fun.

Quick text summary:

Rough Averages
2.4.21 Peak load Test: Maximum Jobs per Minute 5220.50 (average of 3 runs)
2.4.21 run two Peak load Test: Maximum Jobs per Minute 5177.56 (average of 3 
runs)
2.5.71 Peak load Test: Maximum Jobs per Minute 5337.25 (average of 3 runs)
2.5.72 Peak load Test: Maximum Jobs per Minute 5344.51 (average of 3 runs)
2.5.74 Peak load Test: Maximum Jobs per Minute 5314.85 (average of 3 runs)
2.5.75 Peak load Test: Maximum Jobs per Minute 5375.74 (average of 3 runs)
2.5.75-mm1 Peak load Test: Maximum Jobs per Minute 5265.65 (average of 3 runs)
2.6.0-test1 Peak load Test: Maximum Jobs per Minute 5368.09 (average of 3 runs)

cliffw 
OSDL

