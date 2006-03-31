Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751152AbWCaRph@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751152AbWCaRph (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 12:45:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751323AbWCaRph
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 12:45:37 -0500
Received: from a1819.adsl.pool.eol.hu ([81.0.120.41]:45474 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S1751152AbWCaRph (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 12:45:37 -0500
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org
Subject: [PATCH 0/10] fuse: updates
Message-Id: <E1FPNgV-0005YY-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 31 Mar 2006 19:45:19 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Various FUSE updates.

Sorry for the late submission, I wanted to set up a public git
repository, but not yet got an account on kernel.org for it.

Patches 0-9 are independent from other patches.

Patch 10 is dependent on the locking patches.

If not too late they should go into 2.6.17.  Or if locking changes are
deemed to simmer in -mm longer, then patch 10 should be delayed with
them.

Thanks,
Miklos
