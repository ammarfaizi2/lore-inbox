Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267613AbTB1H55>; Fri, 28 Feb 2003 02:57:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267622AbTB1H54>; Fri, 28 Feb 2003 02:57:56 -0500
Received: from quechua.inka.de ([193.197.184.2]:8084 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S267613AbTB1H54>;
	Fri, 28 Feb 2003 02:57:56 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: Patch: 2.5.62 devfs shrink
In-Reply-To: <200302280314.TAA11682@baldur.yggdrasil.com>
References: <200302280314.TAA11682@baldur.yggdrasil.com>
Date: Fri, 28 Feb 2003 09:08:11 +0100
Message-Id: <20030228080811.68B2220DE9@dungeon.inka.de>
From: aj@dungeon.inka.de (Andreas Jellinghaus)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In case there is a cleanup of /dev/* names,
I'd like to also point out this (seen on 2.4.*):
/dev/printers/0
but
/dev/cdroms/cdrom0
./discs/disc0

If there are incompatible changes, it might
be good to cleanup all ugly parts, not only some.

Andreas
