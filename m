Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131021AbRBWJsd>; Fri, 23 Feb 2001 04:48:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131025AbRBWJsW>; Fri, 23 Feb 2001 04:48:22 -0500
Received: from smtp03.mrf.mail.rcn.net ([207.172.4.62]:54155 "EHLO
	smtp03.mrf.mail.rcn.net") by vger.kernel.org with ESMTP
	id <S131021AbRBWJsI>; Fri, 23 Feb 2001 04:48:08 -0500
Date: Fri, 23 Feb 2001 04:48:12 -0500
From: "Michael B. Allen" <mballen@erols.com>
To: linux-kernel@vger.kernel.org
Subject: xkill and do_try_to_free_pages
Message-ID: <20010223044812.A12008@nano.foo.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Does this have to do with the thing that kills off processes when memory
is low?

Feb 23 04:39:32 nano kernel: VM: do_try_to_free_pages failed for xkill

Maybe xkill should be something allowed to run? The app that I ran
freaked(slrnconf) and snarfed up all my memory rapidly. If I could have
killed it xkill maybe it would not have been a problem.

Just a tought.

Mike
