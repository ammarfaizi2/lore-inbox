Return-Path: <linux-kernel-owner+w=401wt.eu-S1161357AbWLPSpc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161357AbWLPSpc (ORCPT <rfc822;w@1wt.eu>);
	Sat, 16 Dec 2006 13:45:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161361AbWLPSpc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Dec 2006 13:45:32 -0500
Received: from neelix.mvwa.de ([212.223.129.99]:51307 "EHLO neelix.mvwa.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161357AbWLPSpa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Dec 2006 13:45:30 -0500
Subject: Re: 2.6.18 mmap hangs unrelated apps
From: Christian Kuhn <lollingola@lollingola.de>
To: Michal Sabala <lkml@saahbs.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1166273992.14760.63.camel@luna.lollingola.homeip.net>
References: <20061215023014.GC2721@prosiaczek>
	 <1166273992.14760.63.camel@luna.lollingola.homeip.net>
Content-Type: text/plain
Date: Sat, 16 Dec 2006 19:45:10 +0100
Message-Id: <1166294710.12653.24.camel@luna.lollingola.homeip.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I enabled some kernel hacking options on 2.6.20-rc1 and ran sysrq t when
the problem occured.

Some hopefully usefull information in the links below: .config, dmesg,
vmstat and vmstat -m. Sorry for the links, I do not know what is
relevant and this is too much to inline for this list (is it?)


http://www.lollingola.de/kernel/dmesg
http://www.lollingola.de/kernel/vmstat
http://www.lollingola.de/kernel/vmstat-m
http://www.lollingola.de/kernel/config-2.6.20-rc1


Christian

