Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317582AbSINWcj>; Sat, 14 Sep 2002 18:32:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317589AbSINWcj>; Sat, 14 Sep 2002 18:32:39 -0400
Received: from 218-bem-2.acn.waw.pl ([62.121.81.218]:55559 "EHLO
	woland.mmm.ozarow-12.waw.pl") by vger.kernel.org with ESMTP
	id <S317582AbSINWci>; Sat, 14 Sep 2002 18:32:38 -0400
Date: Sun, 15 Sep 2002 00:37:26 +0200
From: Michal Kochanowicz <michal@michal.waw.pl>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: rmmod ip_conntrack locks
Message-ID: <20020914223726.GC12639@wieszak.mmm.ozarow-12.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4i
Organization: Happy GNU/Linux Users
X-Signature-Tagline-Copyright: Piotr Zientarski, 1999-2001
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I'm using plain 2.4.19 on small router with masquerade. Every time I try
to remove ip_conntrack from memory process hangs. It can't be kill -9.
Please let me know what kind of information can be useful to trace this
problem.

I've found in archives that person reporting similar problem some time
ago was asked to show result of ps lax. So here it is:
100     0 13622 12852  14   0  1484  432 -      R    pts/0      3:08 rmmod ip_co

Regards
-- 
--= Michal Kochanowicz =--==--==BOFH==--==--= michal@michal.waw.pl =--
--= finger me for PGP public key or visit http://michal.waw.pl/PGP =--
--==--==--==--==--==-- Vodka. Connecting people.--==--==--==--==--==--
A chodzenie po górach SSIE!!!
