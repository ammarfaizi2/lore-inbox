Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262074AbTKCOti (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Nov 2003 09:49:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262076AbTKCOth
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Nov 2003 09:49:37 -0500
Received: from h1ab.lcom.net ([216.51.237.171]:24969 "EHLO digitasaru.net")
	by vger.kernel.org with ESMTP id S262074AbTKCOtg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Nov 2003 09:49:36 -0500
Date: Mon, 3 Nov 2003 08:49:33 -0600
From: Joseph Pingenot <trelane@digitasaru.net>
To: linux-kernel@vger.kernel.org
Subject: IA64/x86-64 and execution protection support?
Message-ID: <20031103144932.GC31953@digitasaru.net>
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

I was reading El Reg this morning when they discussed "execution protection"
  on the new Intel (IA64) and AMD (K8 and above) chips.
Does the Linux kernel have support for preventing execution of certain
  memory regions on those architectures?
Also, I know that some implementations of x86 stack protection are out there;
  I've not seen them in the vanilla kernels; is there any plan to implement
  them?

Thank you!
-Joseph
-- 
Joseph===============================================trelane@digitasaru.net
"Asked by CollabNet CTO Brian Behlendorf whether Microsoft will enforce its
 patents against open source projects, Mundie replied, 'Yes, absolutely.'
 An audience member pointed out that many open source projects aren't
 funded and so can't afford legal representation to rival Microsoft's. 'Oh
 well,' said Mundie. 'Get your money, and let's go to court.' 
Microsoft's patents only defensive? http://swpat.ffii.org/players/microsoft
