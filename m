Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263099AbSJGP3I>; Mon, 7 Oct 2002 11:29:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263101AbSJGP3H>; Mon, 7 Oct 2002 11:29:07 -0400
Received: from mailout03.sul.t-online.com ([194.25.134.81]:44946 "EHLO
	mailout03.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S263099AbSJGP3D>; Mon, 7 Oct 2002 11:29:03 -0400
Message-Id: <4.3.2.7.2.20021007173756.00c5c4c0@192.168.6.2>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Mon, 07 Oct 2002 17:39:34 +0200
To: linux-kernel@vger.kernel.org
From: Roger While <RogerWhile@sim-basis.de>
Subject: Make 2.5.40-ac5 fails
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
X-MDRemoteIP: 192.168.6.50
X-Return-Path: RogerWhile@sim-basis.de
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As subject says :
depmod: *** Unresolved symbols in 
/lib/modules/2.5.40-ac5/kernel/drivers/isdn/hisax/hisax.o
depmod:         cli
depmod:         restore_flags
depmod:         sti
depmod:         save_flags
depmod: *** Unresolved symbols in 
/lib/modules/2.5.40-ac5/kernel/drivers/isdn/i4l/isdn.o
depmod:         cli
depmod:         restore_flags
depmod:         eth_header
depmod:         sti
depmod:         save_flags
depmod: *** Unresolved symbols in 
/lib/modules/2.5.40-ac5/kernel/net/ipv4/netfilter/ipt_owner.o
depmod:         next_thread
depmod:         find_task_by_pid
depmod: *** Unresolved symbols in 
/lib/modules/2.5.40-ac5/kernel/net/ipv6/netfilter/ip6t_owner.o
depmod:         next_thread
depmod:         find_task_by_pid
make: *** [_modinst_post] Error 1


