Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262484AbVBEUZH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262484AbVBEUZH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 15:25:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264322AbVBEUZH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 15:25:07 -0500
Received: from h01.hostsharing.net ([212.42.230.152]:61919 "EHLO
	pima.hostsharing.net") by vger.kernel.org with ESMTP
	id S271349AbVBEUYm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 15:24:42 -0500
Date: Sat, 5 Feb 2005 21:24:32 +0100
From: Elimar Riesebieter <riesebie@lxtec.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.6.11-rc3: No vmlinux on ppc
Message-ID: <20050205202432.GA25459@aragorn.home.lxtec.de>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
Organization: LXTEC
X-gnupg-key-fingerprint: BE65 85E4 4867 7E9B 1F2A  B2CE DC88 3C6E C54F 7FB0
User-Agent: Mutt/1.5.6+lxtec-20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I tried to built the above Kernel on my powerbook:

...
  GEN     .version
  CHK     include/linux/compile.h
  UPD     include/linux/compile.h
  CC      init/version.o
  LD      init/built-in.o
  LD      .tmp_vmlinux1
mm/built-in.o(.rodata.cst4+0x0): relocation truncated to fit: R_PPC_ADDR32 empty_zero_page+40000000
make[1]: *** [.tmp_vmlinux1] Error 1

GNU ld version 2.15
gcc (GCC) 3.4.4 20041218 (prerelease) (Debian 3.4.3-7)


Please cc me as I am not subscribed.

THX Elimar

-- 
  The path to source is always uphill!
                                -unknown-

