Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261392AbVDCAid@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261392AbVDCAid (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Apr 2005 19:38:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261402AbVDCAid
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Apr 2005 19:38:33 -0500
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:52706 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S261392AbVDCAi2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Apr 2005 19:38:28 -0500
Subject: prepatch 2.6.12-rc1 does not apply cleanly to linux-2.6.11.6
From: "Joseph E. Sacco, Ph.D." <joseph_sacco@comcast.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1112488705.24524.21.camel@plantain.jesacco.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.ydl.1) 
Date: Sat, 02 Apr 2005 19:38:25 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

prepatch 2.6.12-rc1 [2005-03-18 02:52 UTC] does not apply cleanly to
linux-2.6.11.6:

./net/ipv4/fib_hash.c.rej
./net/ipv4/tcp_timer.c.rej
./net/netrom/nr_in.c.rej
./net/xfrm/xfrm_state.c.rej
./sound/pci/ac97/ac97_codec.c.rej
./drivers/pci/hotplug/pciehp_ctrl.c.rej
./drivers/net/wan/hd6457x.c.rej
./drivers/net/tun.c.rej
./drivers/net/amd8111e.c.rej
./drivers/net/via-rhine.c.rej
./drivers/net/ppp_async.c.rej
./drivers/net/r8169.c.rej
./drivers/net/sis900.c.rej
./drivers/media/video/saa7110.c.rej
./drivers/media/video/bt819.c.rej
./drivers/media/video/adv7170.c.rej
./drivers/media/video/adv7175.c.rej
./drivers/media/video/saa7114.c.rej
./drivers/media/video/saa7185.c.rej
./drivers/input/serio/i8042-x86ia64io.h.rej
./drivers/md/raid6altivec.uc.rej
./kernel/signal.c.rej
./fs/cramfs/inode.c.rej
./fs/isofs/rock.c.rej
./fs/isofs/inode.c.rej
./fs/eventpoll.c.rej
./fs/exec.c.rej
./arch/ppc/oprofile/op_model_fsl_booke.c.rej
./arch/ppc/platforms/4xx/ocotea.h.rej
./arch/ppc/platforms/4xx/ebony.h.rej
./arch/ppc/platforms/4xx/luan.h.rej
./Makefile.rej


-Joseph

-- 
joseph_sacco[at]comcast[dot]net

