Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261549AbTITC3f (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 22:29:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261569AbTITC3f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 22:29:35 -0400
Received: from sccrmhc12.comcast.net ([204.127.202.56]:63632 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261549AbTITC3e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 22:29:34 -0400
Date: Fri, 19 Sep 2003 19:31:03 -0700
From: John Wendel <jwendel10@comcast.net>
To: linux-kernel@vger.kernel.org
Subject: [ATTN IBM Guys] NMI count on X440 box
Message-Id: <20030919193103.1d08fbff.jwendel10@comcast.net>
Organization: WizardControl
X-Mailer: Sylpheed version 0.9.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


< curious>

I just noticed that our 8-way X440 is showing (in /proc/interrupts)
about 100 NMIs / second, on each CPU. Would some kind soul please tell
me if this is OK? A brief explanation of what this interrupt is being
used for would be appreciated.

We're running the latest RH Advanced server kernel.

</curious>

Sorry if this is a stupid question.

Thanks,

John
