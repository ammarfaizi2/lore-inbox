Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274968AbRIYLh5>; Tue, 25 Sep 2001 07:37:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274976AbRIYLhh>; Tue, 25 Sep 2001 07:37:37 -0400
Received: from 202-54-39-145.tatainfotech.co.in ([202.54.39.145]:36103 "EHLO
	brelay.tatainfotech.com") by vger.kernel.org with ESMTP
	id <S274972AbRIYLhc>; Tue, 25 Sep 2001 07:37:32 -0400
Date: Tue, 25 Sep 2001 16:16:49 +0530 (IST)
From: "SATHISH.J" <sathish.j@tatainfotech.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Problem compiling 2.4.9 kernel (fwd)
Message-ID: <Pine.LNX.4.10.10109251616130.3864-100000@blrmail>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I compiled the linux 2.4.9 kernel with the kdb patch "kdb-v1.8-2.4.9" got
from the "oss.sgi.com" site. I did "make menuconfig" and "make dep" after
which I ran "make bzImage" which stopped with the error message:

/bin/sh: /sbin/kallsyms: No such file or directory
make[1]: *** [kallsyms] Error 126
make[1]: Leaving directory `/home/satishj/source/linux-2.4.9'
make: *** [vmlinux] Error 2

Please tell me what I should change so that i can compile 2.4.9 kernel
with kdb patch.

Thanks in advance,
Warm regards,
sathish.j



