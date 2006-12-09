Return-Path: <linux-kernel-owner+w=401wt.eu-S1761786AbWLITBK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761786AbWLITBK (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 14:01:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761822AbWLITBK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 14:01:10 -0500
Received: from moutng.kundenserver.de ([212.227.126.186]:53370 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761786AbWLITBJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 14:01:09 -0500
From: Oliver Bock <o.bock@fh-wolfenbuettel.de>
To: Ingo Molnar <mingo@elte.hu>
Subject: Realtime: vanilla 2.6.19 with 2.6.19-rt11 patch doesn't boot
Date: Sat, 9 Dec 2006 20:01:01 +0100
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612092001.01542.o.bock@fh-wolfenbuettel.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:dd33dd6c1d5f49fc970db4042b12446b
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

I tried to boot a vanilla 2.6.19 kernel with your 2.6.19-rt11 patch but 
without success. However, the patch applied without a single error and the 
vanilla kernel (without the patch) works fine so far. As my screen just stays 
black and as there's no HD activity after selecting the kernel in grub, I 
suppose that it might be related to the new Areca RAID driver I use (compiled 
in because all my partitions reside on a RAID volume) in conjunction with 
your patch...

Some system info:
- Athlon64 (i386)
- Debian (etch)

Any idea?


Thanks in advance,
Oliver
