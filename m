Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264022AbUFFX0j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264022AbUFFX0j (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 19:26:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264012AbUFFX0j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 19:26:39 -0400
Received: from aun.it.uu.se ([130.238.12.36]:36047 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S264034AbUFFX0i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 19:26:38 -0400
Date: Mon, 7 Jun 2004 01:26:21 +0200 (MEST)
Message-Id: <200406062326.i56NQLCa009188@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: benh@kernel.crashing.org
Subject: Re: [BUG] asm-ppc/pgtable.h breakage from 2.6.7-rc1-bk4
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.linuxppc.org,
       paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 06 Jun 2004 15:48:01 -0500, Benjamin Herrenschmidt wrote:
>Ok, please  tell me if this patch works, I don't have a machine
>to test here. If it's ok, I'll send it to andrew/linus.

Yes, this (actually the two patches you already sent to Linus
and Andrew) fixes the problem on my 603.

/Mikael
