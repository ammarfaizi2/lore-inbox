Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932681AbWKMVWV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932681AbWKMVWV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 16:22:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932687AbWKMVWV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 16:22:21 -0500
Received: from raven.upol.cz ([158.194.120.4]:135 "EHLO raven.upol.cz")
	by vger.kernel.org with ESMTP id S932681AbWKMVWU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 16:22:20 -0500
To: Alan <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, olecom@flower.upol.cz
Subject: Re: drivers/uio
In-Reply-To: <20061110232819.378b250a@localhost.localdomain>
References: <20061110232819.378b250a@localhost.localdomain>
Organization: Palacky University in Olomouc, experimental physics department.
Date: Mon, 13 Nov 2006 21:29:01 +0000
Message-Id: <E1GjjMT-00011e-95@flower>
From: Oleg Verych <olecom@flower.upol.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2006-11-10, Mister Alan wrote:
> We had a discussion a while back about drivers/uio and the fact the stuff
> was buggy, contained security holes and not really fit/ready for -mm.
> Since that point nobody has fixed it (in part because they are doing
.... and removing ...
> vastly cooler stuff elsewhere in the kernel) so I think its time
> drivers/uio in -mm talk a walk to the bitbucket until someone makes it
> secure and resurrects it if needed.

P.S. Unfortunately, devfs hadn't found its new parents. I hope it will.
____
