Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263458AbTFPHCG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 03:02:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263487AbTFPHCG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 03:02:06 -0400
Received: from auth22.inet.co.th ([203.150.14.104]:37129 "EHLO
	auth22.inet.co.th") by vger.kernel.org with ESMTP id S263458AbTFPHCD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 03:02:03 -0400
From: Michael Frank <mflt1@micrologica.com.hk>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.71-mm1 PCMCIA Yenta socket nonfunctional
Date: Mon, 16 Jun 2003 15:10:39 +0800
User-Agent: KMail/1.5.2
References: <200306161343.03663.mflt1@micrologica.com.hk>
In-Reply-To: <200306161343.03663.mflt1@micrologica.com.hk>
X-OS: KDE 3 on GNU/Linux
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200306161503.01557.mflt1@micrologica.com.hk>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

$ cardmgr -V
cardmgr version 3.2.4

Running card manager manually:

# cardmgr
cardmgr[2871]: no pcmcia driver in /proc/devices

# cat /proc/devices
Character devices:
  1 mem
  2 pty
  3 ttyp
  4 /dev/vc/0
  4 tty
  4 ttyS
  5 /dev/tty
  5 /dev/console
  5 /dev/ptmx
  7 vcs
 10 misc
 13 input
 29 fb
108 ppp
128 ptm
136 pts
202 cpu/msr
203 cpu/cpuid

Block devices:
  1 ramdisk
  3 ide0
  7 loop
 43 nbd

Regards
Michael

P.S. pls cc me

