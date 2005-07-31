Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263188AbVGaAuP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263188AbVGaAuP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 20:50:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263198AbVGaAuP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 20:50:15 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:41443 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S263188AbVGaAuM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 20:50:12 -0400
Date: Sun, 31 Jul 2005 02:50:03 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Sam Ravnborg <sam@ravnborg.org>
cc: kbuild-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [RFD] kconfig - introduce cond-source
In-Reply-To: <20050730220100.GA3240@mars.ravnborg.org>
Message-ID: <Pine.LNX.4.61.0507310247410.3728@scrub.home>
References: <20050730220100.GA3240@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 31 Jul 2005, Sam Ravnborg wrote:

> In a couple of cases I have had the need to include a Kconfig file only
> if present.
> The current 'source' directive works as one would expect. It bails out
> if the file is missing.

I don't really like it, it's an open invitation to abuse.
I'd rather like to see the user first, which might need it.

bye, Roman
