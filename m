Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266479AbRGLSGa>; Thu, 12 Jul 2001 14:06:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266483AbRGLSGV>; Thu, 12 Jul 2001 14:06:21 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:53769 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S266479AbRGLSGE>;
	Thu, 12 Jul 2001 14:06:04 -0400
Date: Thu, 12 Jul 2001 15:05:50 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: "C. Slater" <cslater@wcnet.org>, <linux-kernel@vger.kernel.org>
Subject: Re: Switching Kernels without Rebooting?
In-Reply-To: <200107121623.f6CGNV569053@saturn.cs.uml.edu>
Message-ID: <Pine.LNX.4.33L.0107121504270.20836-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Jul 2001, Albert D. Cahalan wrote:

> I think I see a business opportunity here.

	[snip technically risky idea]

> The 24x7 places might be willing to pay somebody to do this.

Unlikely. They need hardware redundancy anyway, so they'll
just upgrade their cluster node-by-node, without doing
risky and potentially data-corrupting things like live
kernel upgrades.

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

