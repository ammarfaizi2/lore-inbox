Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267013AbSK2LKI>; Fri, 29 Nov 2002 06:10:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267020AbSK2LKH>; Fri, 29 Nov 2002 06:10:07 -0500
Received: from dp.samba.org ([66.70.73.150]:6589 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S267013AbSK2LKG>;
	Fri, 29 Nov 2002 06:10:06 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: linux-kernel@vger.kernel.org
Cc: "Marco d'Itri" <md@Linux.IT>
Subject: [PATCH] 2.5.50 conglomerate module fixes patch
Date: Fri, 29 Nov 2002 21:57:09 +1100
Message-Id: <20021129111729.EE41C2C2E3@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patches which are pending inclusion by Linus are rolled into one
file:

	http://www.[COUNTRY].kernel.org/pub/linux/kernel/people/rusty/modules/2.5.50-patches.gz

This does not include the "calling request_module() from module init",
as I'm waiting for confirmation that that patch actually works.

Please report bugs to me.

Cheers,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
