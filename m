Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263571AbUBREZx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 23:25:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263595AbUBREXc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 23:23:32 -0500
Received: from intra.cyclades.com ([64.186.161.6]:65441 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S263101AbUBREXL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 23:23:11 -0500
Date: Wed, 18 Feb 2004 02:11:24 -0300 (BRT)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: linux-kernel@vger.kernel.org
Subject: Linux 2.4.25-rc4
Message-ID: <Pine.LNX.4.58L.0402180207540.4852@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Here goes release candidate 4, including a few small fixes.

If nothing bad shows up, this will become final.


Summary of changes from v2.4.25-rc3 to v2.4.25-rc4
============================================

<davem:nuts.davemloft.net>:
  o [SPARC64]: Fix build with sysctl disabled

<marcelo:logos.cnet>:
  o Changed EXTRAVERSION to -rc4

Andrea Arcangeli:
  o Return proper do_munmap() error code

Hideaki Yoshifuji:
  o [NETFILTER]: Better verification of TCP header len in ip{,6}_tables.c


