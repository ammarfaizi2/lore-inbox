Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932280AbWGLAXu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932280AbWGLAXu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 20:23:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932286AbWGLAXt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 20:23:49 -0400
Received: from theorix.CeNTIE.NET.au ([202.9.6.84]:65242 "HELO
	theorix.centie.net.au") by vger.kernel.org with SMTP
	id S932280AbWGLAXt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 20:23:49 -0400
Subject: Where is RLIMIT_RT_CPU?
From: Jean-Marc Valin <jean-marc.valin@usherbrooke.ca>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 12 Jul 2006 10:23:45 +1000
Message-Id: <1152663825.27958.5.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I saw many references to RLIMIT_RT_CPU (e.g. in
http://lwn.net/Articles/120797/ ) as a way of limiting the amount of CPU
an unprivileged task can use at real-time priority. My understand was
that the feature had been merged into 2.6.12 as part of Ingo's rt-limit
patches. Unfortunately, I can't find any reference to that on my system
(latest Ubuntu), so I'm wondering where it's gone. Has it been removed,
renamed, ...? Considering that Ubuntu Dapper currently allows any user
to make unlimited use of realtime scheduling, this feature would be
really useful to prevent user apps from accidently crashing the system.

Thanks,

	Jean-Marc

P.S. Please CC me since I'm not subscribed to the list.
