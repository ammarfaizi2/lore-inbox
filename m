Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270765AbTGNUXX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 16:23:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270764AbTGNUN6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 16:13:58 -0400
Received: from mx1.elte.hu ([157.181.1.137]:400 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S270793AbTGNUK7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 16:10:59 -0400
Date: Mon, 14 Jul 2003 22:24:55 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: =?koi8-r?Q?=22?=Kirill Korotaev=?koi8-r?Q?=22=20?= <kksx@mail.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [announce, patch] 4G/4G split on x86, 64 GB RAM (and more)
 support
In-Reply-To: <E19aCeB-000ICs-00.kksx-mail-ru@f23.mail.ru>
Message-ID: <Pine.LNX.4.44.0307142223490.6541-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 9 Jul 2003, [koi8-r] "Kirill Korotaev[koi8-r] "  wrote:

> 11. machine_real_restart()

> BTW, as for me this path didn't reboot at all until I fixed it. Check
> your kernel with option "reboot=b"

is this problem 4G/4G specific, or is there a generic kernel bug here?

	Ingo

