Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261323AbUKIBdZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261323AbUKIBdZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 20:33:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261329AbUKIBc3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 20:32:29 -0500
Received: from neapel230.server4you.de ([217.172.187.230]:20445 "EHLO
	neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S261323AbUKIBa7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 20:30:59 -0500
Date: Tue, 09 Nov 2004 02:30:57 +0100
From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
To: <hirofumi@mail.parknet.co.jp>, Hirofumi@neapel230.server4you.de,
       OGAWA@neapel230.server4you.de
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] VFAT cleanup
Message-ID: <41901DD1.mail5VX1GOOYK@lsrfire.ath.cx>
User-Agent: nail 10.5 4/27/03
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

the following four mails contain patches for a basic cleanup of the
VFAT filename handling code. The intention is to get the (hopefully)
easy changes merged before I post more controversial ones. The patches
are against 2.6.10-rc1-bk18 and they are tested lightly.

Any comments are welcome.

Thanks,
René
