Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265357AbUAYX2o (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 18:28:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265359AbUAYX2o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 18:28:44 -0500
Received: from auemail2.lucent.com ([192.11.223.163]:949 "EHLO
	auemail2.firewall.lucent.com") by vger.kernel.org with ESMTP
	id S265357AbUAYX2b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 18:28:31 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16404.20728.437157.703001@gargle.gargle.HOWL>
Date: Sun, 25 Jan 2004 18:27:52 -0500
From: "John Stoffel" <stoffel@lucent.com>
To: DaMouse Networks <damouse@ntlworld.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.2-rc1-mm3 crashes
In-Reply-To: <20040125231933.09f317d0@EozVul.WORKGROUP>
References: <20040125231933.09f317d0@EozVul.WORKGROUP>
X-Mailer: VM 7.14 under Emacs 20.6.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


DaMouse> I put 2.6.2-rc1-mm3 on my CPU over the last 12hrs or so and
DaMouse> it keeps just randomly dying, I can't see anything in
DaMouse> syslog. Running X, HT and Links 2.1pre11 at the time. nvidia
DaMouse> kernel module loaded. Any ideas on how to debug this?

Run without the nVidia module and see what happens.  Since it's closed
source, no kernel developer will help until the problem is repeated
without that modules loaded.

John
