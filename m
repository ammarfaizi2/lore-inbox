Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261259AbTIKM5q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 08:57:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261263AbTIKM5p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 08:57:45 -0400
Received: from web60207.mail.yahoo.com ([216.109.118.102]:20911 "HELO
	web60207.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261259AbTIKM5p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 08:57:45 -0400
Message-ID: <20030911125744.89506.qmail@web60207.mail.yahoo.com>
Date: Thu, 11 Sep 2003 05:57:44 -0700 (PDT)
From: "Mr. Mailing List" <mailinglistaddie@yahoo.com>
Subject: horrible usb keyboard bug with latest tests
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, for the last few test kernels, there is a horribly
annoying usb keyboard bug.  after a while in X, or
just when you start putting some input, all the
keyboard lights on on my msnatpro keyboard.  after
that, the keycodes  are screwed up(like the left alt
button)

sometimes one key would stick, like
kkkkkkkkkkkkkkkkkkkkkkkkkk

now with test 5, the keyboard seems to stop responding
completely

the only fix is to unplug/replug keyboard

help?

__________________________________
Do you Yahoo!?
Yahoo! SiteBuilder - Free, easy-to-use web site design software
http://sitebuilder.yahoo.com
