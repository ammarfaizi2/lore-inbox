Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267660AbRGRTUP>; Wed, 18 Jul 2001 15:20:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267833AbRGRTUE>; Wed, 18 Jul 2001 15:20:04 -0400
Received: from pc40.e18.physik.tu-muenchen.de ([129.187.154.153]:42511 "EHLO
	pc40.e18.physik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id <S267660AbRGRTTp>; Wed, 18 Jul 2001 15:19:45 -0400
Date: Wed, 18 Jul 2001 21:19:44 +0200 (CEST)
From: Roland Kuhn <rkuhn@e18.physik.tu-muenchen.de>
To: <linux-kernel@vger.kernel.org>
Subject: menuconfig cannot change numbers in 2.4.6
Message-ID: <Pine.LNX.4.31.0107182110590.24235-100000@pc40.e18.physik.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks!

By make menuconfig I am unable to change e.g.
CONFIG_AIC7XXX_RESET_DELAY_MS in a sane way: I can only add characters to
the string. Was there a change or am I doing something wrong? There are no
errors before...

Ciao,
					Roland

