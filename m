Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263805AbTJETe7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Oct 2003 15:34:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263807AbTJETe7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Oct 2003 15:34:59 -0400
Received: from h1ab.lcom.net ([216.51.237.171]:6016 "EHLO digitasaru.net")
	by vger.kernel.org with ESMTP id S263805AbTJETe4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Oct 2003 15:34:56 -0400
Date: Sun, 5 Oct 2003 14:34:54 -0500
From: Joseph Pingenot <trelane@digitasaru.net>
To: linux-kernel@vger.kernel.org
Subject: aironet cannot talk to base station
Message-ID: <20031005193453.GC3445@digitasaru.net>
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

Hello again.

The aironet driver under 2.6.0-test6-bk6 doesn't seem to be able to see
  my access point anymore.  /proc/driver/aironet/eth1/Config is set the same
  between 2.4.21 and 2.6.0-test6-bk6, yet the 2.4 driver can talk to the
  base station and the 2.6 driver cannot.  Indeed, no AP is listed in Status,
  and a MAC of all FFs is listed in iwconfig's AP listing.
Any ideas?  I see no oopses, just no traffic.  The radio is going, and I
  can see the lights blinking.
Thanks again!

-Joseph

-- 
Joseph===============================================trelane@digitasaru.net
"Asked by CollabNet CTO Brian Behlendorf whether Microsoft will enforce its
 patents against open source projects, Mundie replied, 'Yes, absolutely.'
 An audience member pointed out that many open source projects aren't
 funded and so can't afford legal representation to rival Microsoft's. 'Oh
 well,' said Mundie. 'Get your money, and let's go to court.' 
Microsoft's patents only defensive? http://swpat.ffii.org/players/microsoft
