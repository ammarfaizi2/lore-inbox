Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271114AbTGPU5f (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 16:57:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271123AbTGPU5e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 16:57:34 -0400
Received: from aneto.able.es ([212.97.163.22]:42238 "EHLO aneto.able.es")
	by vger.kernel.org with ESMTP id S271114AbTGPUz0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 16:55:26 -0400
Date: Wed, 16 Jul 2003 23:10:15 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Gregoire Favre <greg@magma.unil.ch>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 260-t1(ac1) don't boot on my Mandrake Cooker (2573 does)
Message-ID: <20030716211015.GA7263@werewolf.able.es>
References: <20030716195502.GD7158@magma.unil.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20030716195502.GD7158@magma.unil.ch>; from greg@magma.unil.ch on Wed, Jul 16, 2003 at 21:55:02 +0200
X-Mailer: Balsa 2.0.12
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 07.16, Gregoire Favre wrote:
> Hello,
> 
> I can't boot with either 2.6.0-test1, neither with 2.6.0-test1-ac1, it
> ends like this:
> 
> NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
> found reiserfs format "3.6" with standard journal
> Reiserfs journal params: device sdb2, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
> reiserfs: checking transaction log (sdb2) for (sdb2)
> Using r5 hash to sort names
> VFS: Mounted root (reiserfs filesystem).
> Mounted devfs on /dev
> Freeing unused kernel memory: 148k freed
> INIT: version 2.85 booting
> INIT: Kernel panic: Attempted to kill init!
> cannot execute "/etc/rc.d/rc.sysinit"
> 
> I don't know what the problem is, as the same configuration works
> juste perfectly with 2.5.73???
> 

gcc --version ?
Did you build 2.5.73 with the same compiler ?

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.2 (Cooker) for i586
Linux 2.4.22-pre5-jam1m (gcc 3.3.1 (Mandrake Linux 9.2 3.3.1-0.2mdk))
