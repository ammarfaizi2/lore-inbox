Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264998AbRGJLyb>; Tue, 10 Jul 2001 07:54:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265086AbRGJLyV>; Tue, 10 Jul 2001 07:54:21 -0400
Received: from tomts8.bellnexxia.net ([209.226.175.52]:48046 "EHLO
	tomts8-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S264998AbRGJLyM>; Tue, 10 Jul 2001 07:54:12 -0400
Content-Type: text/plain; charset=US-ASCII
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: linux-kernel@vger.kernel.org
Subject: 2.4.7-pre5 missing symbols?
Date: Tue, 10 Jul 2001 07:53:59 -0400
X-Mailer: KMail [version 1.2.9]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010710115400.5ED711C495@oscar.casa.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Is it just me or is there something missing?

oscar# depmod -ae 2.4.7-pre5
depmod: *** Unresolved symbols in /lib/modules/2.4.7-pre5/kernel/drivers/net/8139too.o
depmod:         cpu_raise_softirq
depmod: *** Unresolved symbols in /lib/modules/2.4.7-pre5/kernel/drivers/net/ppp_generic.o
depmod:         cpu_raise_softirq
depmod: *** Unresolved symbols in /lib/modules/2.4.7-pre5/kernel/drivers/net/tulip/tulip.o
depmod:         cpu_raise_softirq
depmod: *** Unresolved symbols in /lib/modules/2.4.7-pre5/kernel/drivers/net/via-rhine.o
depmod:         cpu_raise_softirq

Ed Tomlinson
