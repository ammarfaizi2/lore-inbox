Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262564AbUA2Ipa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 03:45:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263609AbUA2Ipa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 03:45:30 -0500
Received: from zone3.gcu-squad.org ([217.19.50.74]:52485 "EHLO
	zone3.gcu-squad.org") by vger.kernel.org with ESMTP id S262564AbUA2Ip3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 03:45:29 -0500
Message-ID: <1075365845.4018c7d5353d7@imp.gcu.info>
Date: Thu, 29 Jan 2004 09:44:05 +0100
From: Jean Delvare <khali@linux-fr.org>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Subject: Re: [BK PATCH] i2c driver fixes for 2.6.2-rc2
References: <20040127233242.GA28891@kroah.com> <20040129004402.GC5830@werewolf.able.es>
In-Reply-To: <20040129004402.GC5830@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.2 / FreeBSD-4.6.2
X-Originating-IP: 62.23.237.137
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting "J.A. Magallon" <jamagallon@able.es>:

> After upgrading to sensors 2.8.3 (first I compiled it, then installed
> the Makdrake package when appeared), my temperatures are still
> mutiplied by 10. I use 2.6.2-rc2-mm1.
> 
> Any ideas ?

As stated on our kernel 2.6 dedicated page [1]: You need lm_sensors CVS
for kernels 2.6.2-rc1 and later.

We plan to release lm_sensors 2.8.4 as soon as Linux 2.6.2 final is
there.

[1] http://secure.netroedge.com/~lm78/kernel26.html

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

