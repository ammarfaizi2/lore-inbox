Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263555AbUGRKhz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263555AbUGRKhz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jul 2004 06:37:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263714AbUGRKhy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jul 2004 06:37:54 -0400
Received: from [212.239.21.88] ([212.239.21.88]:35490 "EHLO
	supertolla.itapac.net") by vger.kernel.org with ESMTP
	id S263555AbUGRKhx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jul 2004 06:37:53 -0400
Date: Sun, 18 Jul 2004 10:37:44 -0000 (Europe/Rome)
Subject: Sound fix/patch on sony vaio TR3E/B
From: "Fabio Pietrosanti" <fabio@pietrosanti.it>
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
Importance: Normal
Message-Id: <20040718103750.96E971D8F7D@supertolla.itapac.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On sony vaio TR3E/B,  japanese subnotebook based on CELERON-M soundcard
get recognized but sound never goes out.

I tryed kernel 2.6.X (latest 2.6.8-rc1) either with alsa either with OSS,
all hardware get correctly recognized, sound program work fine (like
mpg123, mplayer, etc,etc) but sound doesn't exit.

FreeBSD and NetBSD fixed that problem recently with those patches:

http://www.unixmagic.org/ml/netbsd/200308/msg00011.html
http://lists.freebsd.org/pipermail/freebsd-bugs/2004-May/006684.html

Regards

Fabio Pietrosanti (naif)
