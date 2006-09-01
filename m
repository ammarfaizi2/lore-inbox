Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751491AbWIAMvy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751491AbWIAMvy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 08:51:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751494AbWIAMvy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 08:51:54 -0400
Received: from z2.cat.iki.fi ([212.16.98.133]:59877 "EHLO z2.cat.iki.fi")
	by vger.kernel.org with ESMTP id S1751491AbWIAMvy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 08:51:54 -0400
Date: Fri, 1 Sep 2006 15:51:53 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: linux-kernel@vger.kernel.org
Subject: Bogofilter at VGER..
Message-ID: <20060901125153.GC16047@mea-ext.zmailer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

We are considering of taking Bogofilter into use at VGER.
So far we are using it in TEST mode - to teach it about
SPAM and HAM.

I have added some new "cute" email addresses to VGER to
receive any spams that spammers wish to send to us..
See the bottom link at vger's web front page.

You can feed SPAM to  bogofilter-spam@vger.kernel.org,
but do not feed there any HAM.  Not that it would
really affect statistics in any effective way.


IF we take it into use, it will start rejecting messages
at SMTP input phase, so if it rejects legitimate message,
you should get a bounce from your email provider's system.
(Or from zeus.kernel.org, which is vger's backup MX.)

In such case, send the bounce with some explanations to 
<postmaster@vger.kernel.org> -- emails to that address
are explicitely excluded from all filtering!

Regards,
  Matti Aarnio -- one of  <postmaster@vger.kernel.org>
