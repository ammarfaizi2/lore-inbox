Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316161AbSGIJiK>; Tue, 9 Jul 2002 05:38:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316989AbSGIJiJ>; Tue, 9 Jul 2002 05:38:09 -0400
Received: from smtp-out-3.wanadoo.fr ([193.252.19.233]:37295 "EHLO
	mel-rto3.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S316161AbSGIJiI>; Tue, 9 Jul 2002 05:38:08 -0400
Content-Type: text/plain; charset=US-ASCII
From: Duncan Sands <duncan.sands@wanadoo.fr>
To: Dave Jones <davej@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.25-dj1
Date: Tue, 9 Jul 2002 11:40:42 +0200
User-Agent: KMail/1.4.2
References: <20020709004643.GA21880@suse.de>
In-Reply-To: <20020709004643.GA21880@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200207091140.42367.duncan.sands@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

fs/fs.o: In function `proc_pid_stat':
fs/fs.o(.text+0x1fb72): undefined reference to `__udivdi3'
fs/fs.o: In function `kstat_read_proc':
fs/fs.o(.text+0x20b42): undefined reference to `__udivdi3'
fs/fs.o(.text+0x20bd0): undefined reference to `__udivdi3'
make[1]: *** [vmlinux] Error 1
make[1]: Leaving directory `/usr/src/linux-2.5.25-dj1'
make: *** [stamp-build] Error 2
