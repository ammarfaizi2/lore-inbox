Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316383AbSEZVh6>; Sun, 26 May 2002 17:37:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316430AbSEZVh5>; Sun, 26 May 2002 17:37:57 -0400
Received: from mtiwmhc23.worldnet.att.net ([204.127.131.48]:9608 "EHLO
	mtiwmhc23.worldnet.att.net") by vger.kernel.org with ESMTP
	id <S316383AbSEZVh5>; Sun, 26 May 2002 17:37:57 -0400
Date: Sun, 26 May 2002 17:41:44 -0400
To: linux-kernel@vger.kernel.org
Subject: make modules_install fails on 2.5.18 
Message-ID: <20020526214144.GA15209@lnuxlab.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: khromy@lnuxlab.ath.cx (khromy)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

make modules_install on 2.5.18 gives me this:

depmod: *** Unresolved symbols in
/lib/modules/2.5.18/kernel/sound/drivers/opl3/snd-opl3-lib.o
depmod:         snd_hwdep_new
