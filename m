Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267860AbUIUQ4x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267860AbUIUQ4x (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 12:56:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267856AbUIUQ4x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 12:56:53 -0400
Received: from [213.146.154.40] ([213.146.154.40]:36321 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S267863AbUIUQzW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 12:55:22 -0400
Subject: Re: GPL source code for Smart USB 56 modem (includes ALSA AC97
	patch)
From: David Woodhouse <dwmw2@infradead.org>
To: SashaK <sashak@smlink.com>
Cc: Mikael Pettersson <mikpe@csd.uu.se>, linux-kernel@vger.kernel.org
In-Reply-To: <20040912011128.031f804a@localhost>
References: <200409111850.i8BIowaq013662@harpo.it.uu.se>
	 <20040912011128.031f804a@localhost>
Content-Type: text/plain
Message-Id: <1095785705.17821.760.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Tue, 21 Sep 2004 17:55:06 +0100
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-09-12 at 01:11 +0300, SashaK wrote:
> This is exactly that was discussed - 'slamr' is going to be replaced by
> ALSA drivers. I don't know which modem you have, but recent ALSA
> driver (CVS version) already supports ICH, SiS, NForce (snd-intel8x0m),
> ATI IXP (snd-atiixp-modem) and VIA (snd-via82xx-modem) AC97 modems.

What chance of making it work with the ISDN drivers? Should we make an
ALSA driver for ISDN?

-- 
dwmw2

