Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136104AbRD0QLd>; Fri, 27 Apr 2001 12:11:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136094AbRD0QLN>; Fri, 27 Apr 2001 12:11:13 -0400
Received: from mx1.sac.fedex.com ([199.81.208.10]:23307 "EHLO
	mx1.sac.fedex.com") by vger.kernel.org with ESMTP
	id <S136106AbRD0QKW>; Fri, 27 Apr 2001 12:10:22 -0400
Date: Sat, 28 Apr 2001 00:10:50 +0800 (SGT)
From: Jeff Chua <jeffchua@silk.corp.fedex.com>
X-X-Sender: <root@boston.corp.fedex.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: Jeff Chua <jchua@silk.corp.fedex.com>
Subject: 2.4.4-pre8 undefined symbols
Message-ID: <Pine.LNX.4.33.0104280009070.1344-100000@boston.corp.fedex.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


depmod -ae yields the following errors under 2.4.4-pre8

Any fix?


depmod: *** Unresolved symbols in
/lib/modules/2.4.4-pre8/kernel/drivers/char/drm/i810.o
depmod:         rwsem_down_write_failed
depmod:         rwsem_wake
depmod: *** Unresolved symbols in
/lib/modules/2.4.4-pre8/kernel/drivers/char/drm/mga.o
depmod:         rwsem_down_write_failed
depmod:         rwsem_wake
depmod: *** Unresolved symbols in
/lib/modules/2.4.4-pre8/kernel/drivers/char/drm/r128.o
depmod:         rwsem_down_write_failed
depmod:         rwsem_wake
depmod: *** Unresolved symbols in
/lib/modules/2.4.4-pre8/kernel/drivers/char/drm/radeon.o
depmod:         rwsem_down_write_failed
depmod:         rwsem_wake
depmod: *** Unresolved symbols in
/lib/modules/2.4.4-pre8/kernel/drivers/char/drm/tdfx.o
depmod:         rwsem_down_write_failed
depmod:         rwsem_wake
depmod: *** Unresolved symbols in
/lib/modules/2.4.4-pre8/kernel/fs/binfmt_aout.o
depmod:         rwsem_down_write_failed
depmod:         rwsem_wake



Thanks,
Jeff
[ jchua@fedex.com ]

