Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265606AbSJSOBQ>; Sat, 19 Oct 2002 10:01:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265607AbSJSOBP>; Sat, 19 Oct 2002 10:01:15 -0400
Received: from c17928.thoms1.vic.optusnet.com.au ([210.49.249.29]:38528 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S265606AbSJSOBP> convert rfc822-to-8bit; Sat, 19 Oct 2002 10:01:15 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Con Kolivas <conman@kolivas.net>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: ck performance patchset for 2.4.19 broken out as ck10
Date: Sun, 20 Oct 2002 00:05:08 +1000
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200210200005.08444.conman@kolivas.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

My merged performance patchset (-ck) containing

O(1) + batch scheduling
Preemptible
Low Latency
Compressed Caching or
AA VM addons
XFS
ALSA
Supermount

is now available with the last five as separate optional patches for those who 
have asked for it as ck10. Note this is basically unchanged from ck9. Those 
who are not using XFS are recommended to upgrade to this and NOT add the xfs 
patch. The option of the AA VM changes makes this version suitable for SMP 
now.

Available at http://kernel.kolivas.net

Cheers, enjoy!
Con
