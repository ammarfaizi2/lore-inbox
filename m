Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264169AbTEaGpC (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 02:45:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264173AbTEaGpB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 02:45:01 -0400
Received: from mailout08.sul.t-online.com ([194.25.134.20]:12445 "EHLO
	mailout08.sul.t-online.com") by vger.kernel.org with ESMTP
	id S264169AbTEaGpA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 May 2003 02:45:00 -0400
Subject: Re: Hit BUG() in 2.5.70 in mm/slab.c:979
From: celestar@t-online.de (Frank Victor Fischer)
To: Nicolas <linux@1g6.biz>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200305310008.17299.linux@1g6.biz>
References: <1054321005.2063.8.camel@darkstar.fischer.homeip.net>
	 <200305310008.17299.linux@1g6.biz>
Content-Type: text/plain
Organization: 
Message-Id: <1054364308.1931.3.camel@darkstar.fischer.homeip.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 31 May 2003 08:58:29 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I remember there is two differrents e100 drivers which one do you use ?
> e100 one or eepro100 one ?, personally I use the e100 one.

I use the eepro100 driver (the original one), removing CODA file system
support from the kernel solves the problem.

Victor

