Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261225AbUCSVDZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 16:03:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261832AbUCSVDZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 16:03:25 -0500
Received: from fed1mtao05.cox.net ([68.6.19.126]:16022 "EHLO
	fed1mtao05.cox.net") by vger.kernel.org with ESMTP id S261225AbUCSVDY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 16:03:24 -0500
Date: Fri, 19 Mar 2004 14:03:22 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: kgdb-bugreport@lists.sourceforge.net,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Move eth into 'lite' series?
Message-ID: <20040319210322.GA13141@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was thinking, now that netpoll is in 2.6.5-rc1, should we move the
kgdboe driver into the -lite series?  I'd like to say Yes, with a quick
check over the include list.

-- 
Tom Rini
http://gate.crashing.org/~trini/
