Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267377AbUHRGcK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267377AbUHRGcK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 02:32:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268662AbUHRGcJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 02:32:09 -0400
Received: from fw.osdl.org ([65.172.181.6]:4279 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267377AbUHRGcC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 02:32:02 -0400
Date: Tue, 17 Aug 2004 23:30:18 -0700
From: Andrew Morton <akpm@osdl.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org, mochel@digitalimplant.org,
       benh@kernel.crashing.org, david-b@pacbell.net
Subject: Re: [patch] enums to clear suspend-state confusion
Message-Id: <20040817233018.3758786e.akpm@osdl.org>
In-Reply-To: <20040818062601.GB7854@elf.ucw.cz>
References: <20040812120220.GA30816@elf.ucw.cz>
	<20040817212510.GA744@elf.ucw.cz>
	<20040817152742.17d3449d.akpm@osdl.org>
	<20040817223700.GA15046@elf.ucw.cz>
	<20040817161245.50dd6b96.akpm@osdl.org>
	<20040818062601.GB7854@elf.ucw.cz>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> wrote:
>
>  Ok, here's non-ugly patch. It may mean that ugly patch is comming in
>  future (BenH would argue that), but it is probably best solution for
>  now. Please apply,

ok ;)  Let's run with that.
