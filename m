Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265311AbSJRUzE>; Fri, 18 Oct 2002 16:55:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265317AbSJRUzE>; Fri, 18 Oct 2002 16:55:04 -0400
Received: from 217-125-101-55.uc.nombres.ttd.es ([217.125.101.55]:22239 "EHLO
	jep.dhis.org") by vger.kernel.org with ESMTP id <S265311AbSJRUzE>;
	Fri, 18 Oct 2002 16:55:04 -0400
Message-ID: <3DB07685.A9DDE785@jep.dhis.org>
Date: Fri, 18 Oct 2002 23:00:53 +0200
From: Josep Lladonosa i Capell <jep@jep.dhis.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: ca, en, es
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: ide-disk patch for big drives in old bioses for 2.4.19 kernel
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


To Eric Lammerts (or anyone interested in...)

some time ago, you sent a patch for ide-disk.c to perform SET_MAX
command to use big ide disks with old
bioses. It applied against 2.4.18pre1 and 2.5.2pre2.

Any new patch for 2.4.19? It seems it changed, or... is that 'matter'
already implemented in newer kernels?
By taking a look at ide-disk.c, it talks about now using LBA instead of
CHS, and 48 bit,...


--
Salutacions...Josep
http://www.geocities.com/SiliconValley/Horizon/1065/
--



