Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265440AbTGVUkq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 16:40:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269106AbTGVUkq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 16:40:46 -0400
Received: from smtp.terra.es ([213.4.129.129]:37193 "EHLO tsmtp9.mail.isp")
	by vger.kernel.org with ESMTP id S265440AbTGVUkp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 16:40:45 -0400
Date: Tue, 22 Jul 2003 22:55:54 +0200
From: Diego Calleja =?ISO-8859-15?Q?Garc=EDa?= <diegocg@teleline.es>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Cc: martin.zwickel@technotrend.de, tcfelker@mtco.com,
       linux-kernel@vger.kernel.org, sim@netnation.com
Subject: Re: Scheduler starvation (2.5.x, 2.6.0-test1)
Message-Id: <20030722225554.1dbdbb89.diegocg@teleline.es>
In-Reply-To: <1058899302.733.1.camel@teapot.felipe-alfaro.com>
References: <bUil.2D8.11@gated-at.bofh.it>
	<pan.2003.07.22.15.14.44.457281@mtco.com>
	<20030722180442.6c116e1c.martin.zwickel@technotrend.de>
	<1058899302.733.1.camel@teapot.felipe-alfaro.com>
X-Mailer: Sylpheed version 0.9.3 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El 22 Jul 2003 20:41:42 +0200 Felipe Alfaro Solana <felipe_alfaro@linuxmail.org> escribió:

> Could you please test 2.6.0-test1-mm2? It includes some scheduler fixes
> from Con Kolivas that will help in reducing or eliminating your
> starvation issues.

BTW, if/when you've some free time, you could try 2.5.63.
It has the best linux scheduler i've never tried! (for my workload, of
course)

It'd be interesting to try to know what has changed since then.
