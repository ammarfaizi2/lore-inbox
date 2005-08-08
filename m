Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750852AbVHHM7J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750852AbVHHM7J (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 08:59:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750853AbVHHM7J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 08:59:09 -0400
Received: from mxsf19.cluster1.charter.net ([209.225.28.219]:38054 "EHLO
	mxsf19.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S1750850AbVHHM7J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 08:59:09 -0400
X-IronPort-AV: i="3.95,173,1120449600"; 
   d="scan'208"; a="1372963455:sNHT35693202"
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17143.22296.579197.917371@smtp.charter.net>
Date: Mon, 8 Aug 2005 08:59:04 -0400
From: "John Stoffel" <john@stoffel.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.6.13-rc6: aic7xxx testers please..
In-Reply-To: <Pine.LNX.4.58.0508071136020.3258@g5.osdl.org>
References: <Pine.LNX.4.58.0508071136020.3258@g5.osdl.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linus> James and gang found the aic7xxx slowdown that happened after
Linus> 2.6.12, and we'd like to get particular testing that it's
Linus> fixed, so if you have a relevant machine, please do test this.

This might explain why my DLT7000 has been dropping off the bus at
times and requiring a full reboot and/or power cycle of the drive to
get it back working again. 

More details once I've compiled and re-loaded using this.

John
