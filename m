Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261636AbULTUtB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261636AbULTUtB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 15:49:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261641AbULTUtA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 15:49:00 -0500
Received: from moutng.kundenserver.de ([212.227.126.183]:20181 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S261636AbULTUsn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 15:48:43 -0500
To: linux-kernel@vger.kernel.org
Subject: AMD64: timer is running twice as fast as it should (again??)
From: Enrico Scholz <enrico.scholz@informatik.tu-chemnitz.de>
Date: Mon, 20 Dec 2004 21:48:24 +0100
Message-ID: <87ekhkhf1j.fsf@londo.ultra.csn.tu-chemnitz.de>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:cf015127439e61eb16a460417aa16ac1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

with 2.6 kernels, the timer on AMD64 runs exactly twice as fast as
expected. E.g. 'sleep 10' returns after 5 seconds external time.

This behavior was seen with Fedora Core 3 kernel 2.6.9-1.681_FC3 and
2.6.10-rc3-bk13 (both x86_64 mode).

System information can be found at
                http://www.tu-chemnitz.de/~ensc/hw/amd64



Enrico
