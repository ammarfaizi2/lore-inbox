Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262282AbTIBTfq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 15:35:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263830AbTIBTfq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 15:35:46 -0400
Received: from cruftix.physics.uiowa.edu ([128.255.70.79]:16256 "EHLO cruftix")
	by vger.kernel.org with ESMTP id S263772AbTIBTfp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 15:35:45 -0400
Date: Tue, 2 Sep 2003 14:35:32 -0500
From: Joseph Pingenot <trelane@digitasaru.net>
To: linux-kernel@vger.kernel.org
Subject: Lockups with 2.4.22 on a dual P3/Katmai
Message-ID: <20030902193531.GA992@digitasaru.net>
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

I'm getting lockups on my dual P3 Katmai system under 2.4.22.  It worked
  fine with 2.4.21-pre4 (I had an uptime of about 130 or so days), but
  I tried to upgrade to 2.4.22 and it's now started locking up.  I get
  no Oops output or anything.  I've tried both the vanilla 2.4.22 and
  the vanilla 2.4.23-pre1 kernels.
Symptoms: screen will occasionally go blank for a split second, then
  the system locks up after about half an hour to two hours (doesn't seem
  to be a strict time).  When it locks up, I don't notice any LEDs on the
  keyboard flashing, and I don't notice any other activity.  The Magic
  SysRq sync and unmount keys have no effect, so far as I can tell.  It
  seems to be truly locked up.  The reset button will, however, reset
  the computer; I don't have to pull the plug.
Any ideas on what might be causing this?  Anything I can do to get
  a better idea what's going on?
Thanks!

-Joseph

-- 
trelane@digitasaru.net--------------------------------------------------
"We continue to live in a world where all our know-how is locked into
 binary files in an unknown format. If our documents are our corporate
 memory, Microsoft still has us all condemned to Alzheimer's."
    --Simon Phipps, http://theregister.com/content/4/30410.html
