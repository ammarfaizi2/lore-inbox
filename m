Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265493AbUAZE2V (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 23:28:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265494AbUAZE2V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 23:28:21 -0500
Received: from hoemail2.lucent.com ([192.11.226.163]:10968 "EHLO
	hoemail2.firewall.lucent.com") by vger.kernel.org with ESMTP
	id S265493AbUAZE1o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 23:27:44 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16404.38674.244506.359654@gargle.gargle.HOWL>
Date: Sun, 25 Jan 2004 23:26:58 -0500
From: "John Stoffel" <stoffel@lucent.com>
To: "John Stoffel" <stoffel@lucent.com>
Cc: Andi Kleen <ak@muc.de>, Adrian Bunk <bunk@fs.tum.de>,
       Valdis.Kletnieks@vt.edu, Fabio Coatti <cova@ferrara.linux.it>,
       Andrew Morton <akpm@osdl.org>, Eric <eric@cisu.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] Re: Kernels > 2.6.1-mm3 do not boot. - SOLVED
In-Reply-To: <16404.34836.753760.759367@gargle.gargle.HOWL>
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
	<16404.34836.753760.759367@gargle.gargle.HOWL>
X-Mailer: VM 7.14 under Emacs 20.6.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Just a quick followup, but 2.6.2-rc2 also hung in the exact same spot,
after printing out the HighMem zone: line.

Falling back to 2.6.1-mm5 for now.  More testing tomorrow evening when
I get a chance.

John
