Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932177AbWJEQtT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932177AbWJEQtT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 12:49:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932176AbWJEQtT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 12:49:19 -0400
Received: from pne-smtpout2-sn1.fre.skanova.net ([81.228.11.159]:8613 "EHLO
	pne-smtpout2-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S932178AbWJEQtT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 12:49:19 -0400
Date: Thu, 5 Oct 2006 18:49:16 +0200
From: Voluspa <lista1@comhem.se>
To: linux-kernel@vger.kernel.org
Subject: Re: Merge window closed: v2.6.19-rc1
Message-ID: <20061005184916.3bc76868@loke.fish.not>
X-Mailer: Sylpheed-Claws 2.4.0 (GTK+ 2.4.13; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  AR      arch/x86_64/lib/lib.a
  GEN     .version
  CHK     include/linux/compile.h
  UPD     include/linux/compile.h
  CC      init/version.o
  LD      init/built-in.o
  LD      vmlinux
arch/x86_64/kernel/built-in.o: In function `print_trace_warning_symbol':
traps.c:(.text.print_trace_warning_symbol+0xa): undefined reference to
`print_symbol'
make: *** [vmlinux] Error 1

Mvh
Mats Johannesson
