Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264919AbUBOOZ1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 09:25:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264925AbUBOOZ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 09:25:27 -0500
Received: from mail0-96.ewetel.de ([212.6.122.96]:12718 "EHLO mail0.ewetel.de")
	by vger.kernel.org with ESMTP id S264919AbUBOOZ0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 09:25:26 -0500
To: Jamie Lokier <jamie@shareable.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: JFS default behavior (was: UTF-8 in file systems? xfs/extfs/etc.)
In-Reply-To: <1piXj-1d3-3@gated-at.bofh.it>
References: <1nioI-5Re-1@gated-at.bofh.it> <1orqh-6gs-47@gated-at.bofh.it> <1ozGR-60N-1@gated-at.bofh.it> <1oAa3-6pR-37@gated-at.bofh.it> <1oBpi-7pO-1@gated-at.bofh.it> <1oCbM-8oW-9@gated-at.bofh.it> <1p9Kl-7BV-1@gated-at.bofh.it> <1piXj-1d3-3@gated-at.bofh.it>
Date: Sun, 15 Feb 2004 15:26:45 +0100
Message-Id: <E1AsNEL-000055-LW@localhost>
From: Pascal Schmidt <der.eremit@email.de>
X-CheckCompat: OK
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 15 Feb 2004 02:10:05 +0100, you wrote in linux.kernel:

>    Then I did unicode_stop.  Guess what: it put the display back in
>    iso-8859-1 for that virtual terminal, but the keyboard remained stuck
>    in UTF-8 for _all_ virtual terminals.

kbd_mode -a to reset to ASCII mode.

-- 
Ciao,
Pascal
