Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932196AbWAUQ52@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932196AbWAUQ52 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jan 2006 11:57:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932204AbWAUQ52
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jan 2006 11:57:28 -0500
Received: from smtp08.web.de ([217.72.192.226]:48005 "EHLO smtp08.web.de")
	by vger.kernel.org with ESMTP id S932196AbWAUQ52 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jan 2006 11:57:28 -0500
Subject: 2.6.16-rc1-g3ee68c4: powernow-k7: -ENODEV
From: Thomas Meyer <thomas.mey@web.de>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Sat, 21 Jan 2006 17:57:25 +0100
Message-Id: <1137862645.8665.11.camel@hotzenplotz.treehouse>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I switched my config from up to smp support with 2 processors.

trying to modprobe powernow-k7 gives me now:
"
cpufreq-core: trying to register driver powernow-k7
cpufreq-core: adding CPU 0
cpufreq-core: initialization failed
cpufreq-core: no CPU initialized for driver powernow-k7
cpufreq-core: unregistering CPU 0
"

any ideas?

with kind regards
Thomas



