Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262422AbUDDPSb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Apr 2004 11:18:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262425AbUDDPSb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Apr 2004 11:18:31 -0400
Received: from hb6.lcom.net ([216.51.236.182]:5780 "EHLO
	petrus.dynamic.digitasaru.net") by vger.kernel.org with ESMTP
	id S262422AbUDDPSa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Apr 2004 11:18:30 -0400
Date: Sun, 4 Apr 2004 10:18:27 -0500
From: Joseph Pingenot <trelane@digitasaru.net>
To: linux-kernel@vger.kernel.org
Subject: setting metric for an interface: how much work is needed to make this go?
Message-ID: <20040404151824.GE15597@digitasaru.net>
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
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

I poked around a little bit and found that I can't set the metric of an
  interface (not suppported).

How much work would be involved to make this go?  What files/functions/structs
  should I be looking at in the 2.6 source?

Thanks!

-Joseph
-- 
Joseph===============================================trelane@digitasaru.net
      Graduate Student in Physics, Freelance Free Software Developer
