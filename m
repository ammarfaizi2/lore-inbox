Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262375AbTJOGjs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 02:39:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262419AbTJOGjs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 02:39:48 -0400
Received: from chello062178006202.3.11.tuwien.teleweb.at ([62.178.6.202]:2432
	"EHLO flatline.ath.cx") by vger.kernel.org with ESMTP
	id S262375AbTJOGjr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 02:39:47 -0400
Date: Wed, 15 Oct 2003 16:37:35 +0200
From: Andreas Happe <andreashappe@gmx.net>
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test7: unstable on laptop
Message-ID: <20031015143735.GA2331@flatline.chello.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-Request-PGP: subkeys.pgp.net
X-Hangover: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since 2.6.0-test6 Linux just hangs from time to time. Hardware in
question is a omnibook (laptop (hp omnibook 6100, P3m, i830m chipset).
Frequency is about twice a day.

The system hangs regardless of the current workload, sysrg is still
working, but the computer is not ping-able. This problem could be
verified with 2.6.0-test7-bk[3-5], disabling power managment in 
2.6.0-test7-bk5 didn't kills it of.

There are no log messages concerning the bug.

I'm now trying 2.6.0-test7-bk6 without power-management.

Any suggestions?

	--Andreas
