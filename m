Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267364AbUIJM7N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267364AbUIJM7N (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 08:59:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267391AbUIJM7N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 08:59:13 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:40410 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S267364AbUIJM7K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 08:59:10 -0400
Date: Fri, 10 Sep 2004 14:59:00 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Russell King <rmk+lkml@arm.linux.org.uk>
cc: Luke Kenneth Casson Leighton <lkcl@lkcl.net>, linux-kernel@vger.kernel.org
Subject: Re: seems to be impossible to disable CONFIG_SERIAL [2.6.7]
In-Reply-To: <20040910133545.E22599@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.61.0409101457180.981@scrub.home>
References: <20040910110819.GE14060@lkcl.net> <20040910120950.D22599@flint.arm.linux.org.uk>
 <20040910122059.GG14060@lkcl.net> <20040910133545.E22599@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 10 Sep 2004, Russell King wrote:

> It seems to have been introduced by this change:
> 
> http://linux.bkbits.net:8080/linux-2.5/cset@3f6e2888FMm2_snV3LfsXw6tII6QvA?nav=index.html|src/|src/drivers|src/drivers/char|related/drivers/char/Kconfig

Should mwave use register_serial at all?

bye, Roman
