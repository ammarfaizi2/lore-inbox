Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264066AbTFWHTW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 03:19:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264082AbTFWHTW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 03:19:22 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:3712 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S264066AbTFWHTO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 03:19:14 -0400
Date: Mon, 23 Jun 2003 08:40:52 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200306230740.h5N7eqUN000268@81-2-122-30.bradfords.org.uk>
To: akpm@digeo.com, lm@bitmover.com
Subject: Re: GCC speed (was [PATCH] Isapnp warning)
Cc: acme@conectiva.com.br, alan@lxorguk.ukuu.org.uk, cw@f00f.org,
       geert@linux-m68k.org, linux-kernel@vger.kernel.org, perex@suse.cz,
       phillips@arcor.de, torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If you think 3.[23] are slow, go back and compile with 2.7.2 - it's much
> faster than the later versions.  I used to yank newer versions of gcc
> off systems and put 2.7.2 on, I think it was close to 2x faster at
> compilation and made no difference on BK performance.

Out of interest, have you tried compiling BK with tcc?

John.
