Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261346AbSITGzm>; Fri, 20 Sep 2002 02:55:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261228AbSITGyq>; Fri, 20 Sep 2002 02:54:46 -0400
Received: from dp.samba.org ([66.70.73.150]:38528 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S261458AbSITGyP>;
	Fri, 20 Sep 2002 02:54:15 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, Patrick Mochel <mochel@osdl.org>
Subject: [PATCH] Hotplug CPU 4/4: Hot unplug
Date: Fri, 20 Sep 2002 16:58:43 +1000
Message-Id: <20020920065921.93F4A2C0AF@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oops... #4 needs to coordinate with Patrick Mochel re: driverfs CPU
positions.  I'll wait until his goes in then redo it.

Still, the other patches stand on their own and clear some of my
backlog.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
