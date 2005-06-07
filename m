Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261583AbVFGGL0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261583AbVFGGL0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 02:11:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261808AbVFGGL0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 02:11:26 -0400
Received: from pne-smtpout2-sn2.hy.skanova.net ([81.228.8.164]:58837 "EHLO
	pne-smtpout2-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S261583AbVFGGLV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 02:11:21 -0400
Date: Tue, 7 Jun 2005 08:11:16 +0200
From: Voluspa <lista1@telia.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux v2.6.12-rc6
Message-Id: <20050607081116.65c10190.lista1@telia.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  CC      arch/x86_64/kernel/irq.o
  CC      arch/x86_64/kernel/ptrace.o
arch/x86_64/kernel/ptrace.c: In function `putreg':
arch/x86_64/kernel/ptrace.c:285: error: duplicate case value
arch/x86_64/kernel/ptrace.c:280: error: previously used here
make[1]: *** [arch/x86_64/kernel/ptrace.o] Error 1
make: *** [arch/x86_64/kernel] Error 2

real    0m5.524s
user    0m4.227s
sys     0m0.724s

Mvh
Mats Johannesson
--
