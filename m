Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263792AbTJETbm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Oct 2003 15:31:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263793AbTJETbm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Oct 2003 15:31:42 -0400
Received: from h1ab.lcom.net ([216.51.237.171]:5760 "EHLO digitasaru.net")
	by vger.kernel.org with ESMTP id S263792AbTJETbj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Oct 2003 15:31:39 -0400
Date: Sun, 5 Oct 2003 14:31:36 -0500
From: Joseph Pingenot <trelane@digitasaru.net>
To: linux-kernel@vger.kernel.org
Subject: Lockup when switching from X to a VC (or when X goes away) in 2.6.0-test6-bk6
Message-ID: <20031005193136.GB3445@digitasaru.net>
Reply-To: trelane@digitasaru.net
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-School: University of Iowa
X-vi-or-emacs: vi *and* emacs!
X-MSMail-Priority: High
X-Priority: 1 (Highest)
X-MS-TNEF-Correlator: <AFJAUFHRUOGRESULWAOIHFEAUIOFBVHSHNRAIU.monkey@spamcentral.invalid>
X-MimeOLE: Not Produced By Microsoft MimeOLE V5.50.4522.1200
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

There is a curious lockup that happens when I switch from X to a VC or when
  exiting X.
The whole system hangs; no Magic SysRq keys have any effect (as observed on
  screen and by watching the disk activity light).  No oops is printed to
  screen that I can see.
What should I do to trace this further?  Or is it known (I couldn't find it
  looking at the list archives)?
Thanks!

-Joseph
-- 
Joseph===============================================trelane@digitasaru.net
"Asked by CollabNet CTO Brian Behlendorf whether Microsoft will enforce its
 patents against open source projects, Mundie replied, 'Yes, absolutely.'
 An audience member pointed out that many open source projects aren't
 funded and so can't afford legal representation to rival Microsoft's. 'Oh
 well,' said Mundie. 'Get your money, and let's go to court.' 
Microsoft's patents only defensive? http://swpat.ffii.org/players/microsoft
