Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264629AbUEOChq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264629AbUEOChq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 22:37:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264633AbUEOChq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 22:37:46 -0400
Received: from zeus.kernel.org ([204.152.189.113]:34547 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S264629AbUEOCho (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 22:37:44 -0400
Date: Fri, 14 May 2004 21:40:24 -0400 (EDT)
From: Nicolas Pitre <nico@cam.org>
X-X-Sender: nico@xanadu.home
To: Pavel Machek <pavel@ucw.cz>
cc: Todd Poynor <tpoynor@mvista.com>,
       Patrick Mochel <mochel@digitalimplant.org>,
       <linux-hotplug-devel@lists.sourceforge.net>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Hotplug for device power state changes
In-Reply-To: <20040514025053.GA14773@elf.ucw.cz>
Message-ID: <Pine.LNX.4.44.0405142129470.15495-100000@xanadu.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 May 2004, Pavel Machek wrote:

> In case of that dual-core CPU, does linux really run on both CPUs?

No, only one of them.  One is usually an ARM core which runs Linux while the
other is a DSP.

> Do we get sources for GSM network stack, too?

Since they run on the DSP then probably not.

> Is there some preliminary docs about such beasts available somewhere?
> Dual CPU design for phone certainly looks interesting...

Try Google with "site:www.ti.com OMAP".


Nicolas

