Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265393AbUAZCki (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 21:40:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265420AbUAZCki
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 21:40:38 -0500
Received: from hoemail2.lucent.com ([192.11.226.163]:397 "EHLO
	hoemail2.firewall.lucent.com") by vger.kernel.org with ESMTP
	id S265393AbUAZCkh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 21:40:37 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16404.32256.530726.601792@gargle.gargle.HOWL>
Date: Sun, 25 Jan 2004 21:40:00 -0500
From: "John Stoffel" <stoffel@lucent.com>
To: Andi Kleen <ak@muc.de>
Cc: John Stoffel <stoffel@lucent.com>, Adrian Bunk <bunk@fs.tum.de>,
       Valdis.Kletnieks@vt.edu, Fabio Coatti <cova@ferrara.linux.it>,
       Andrew Morton <akpm@osdl.org>, Eric <eric@cisu.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] Re: Kernels > 2.6.1-mm3 do not boot. - SOLVED
In-Reply-To: <20040125234756.GF28576@colin2.muc.de>
References: <200401251811.27890.cova@ferrara.linux.it>
	<20040125173048.GL513@fs.tum.de>
	<20040125174837.GB16962@colin2.muc.de>
	<200401251800.i0PI0SmV001246@turing-police.cc.vt.edu>
	<20040125191232.GC16962@colin2.muc.de>
	<16404.9520.764788.21497@gargle.gargle.HOWL>
	<20040125202557.GD16962@colin2.muc.de>
	<16404.10496.50601.268391@gargle.gargle.HOWL>
	<20040125214920.GP513@fs.tum.de>
	<16404.20183.783477.596431@gargle.gargle.HOWL>
	<20040125234756.GF28576@colin2.muc.de>
X-Mailer: VM 7.14 under Emacs 20.6.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andi,

I've got the serial cable setu, now I'm compiling 2.6.2-rc1 based on
the config from 2.6.1-mm5, which is what I'm running right now.  So it
looks like my issue is possibly with the new CPU selection stuff in
2.6.2-rc1 and later -mm kernels.  Hopefully I'll get this up and
running soon.

Thanks for your help and the early printk patch.

John
