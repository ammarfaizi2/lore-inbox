Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264487AbTLCDmO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 22:42:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264492AbTLCDmO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 22:42:14 -0500
Received: from fw.osdl.org ([65.172.181.6]:49832 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264487AbTLCDmM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 22:42:12 -0500
Date: Tue, 2 Dec 2003 19:42:08 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Xose Vazquez Perez <xose@wanadoo.es>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: ATI boards [was Re: Linux 2.4 future]
In-Reply-To: <3FCD5533.8050105@wanadoo.es>
Message-ID: <Pine.LNX.4.58.0312021939400.2072@home.osdl.org>
References: <3FCD5533.8050105@wanadoo.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 3 Dec 2003, Xose Vazquez Perez wrote:
> Harald Arnesen wrote:
>
> > I second that. I have an ATI Radeon 9200, and I can play Tuxracer,
> > America's Army (BOO!), and any other 3D-game without any problem.
>
> Torvalds was talking about R200 chip. Those boards are 8500, and
> 9100/8500 LE. IMO they are the best for FOSS.

Actually, the whole R2x0 family seems to be largely supported by the DRI
drivers.

The newer cards just need a recent enough DRI server to know about them,
but they should otherwise be ok.

It's the R300-based cards (ATI 9800 & friends) that apparently don't get
any open-source 3D acceleration right now.

(But hey, I may be wrong - I follow the DRI stuff only sporadically).

			Linus
