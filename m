Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266164AbRGLQYf>; Thu, 12 Jul 2001 12:24:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266166AbRGLQY0>; Thu, 12 Jul 2001 12:24:26 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:18191 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S266164AbRGLQYS>;
	Thu, 12 Jul 2001 12:24:18 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200107121623.f6CGNV569053@saturn.cs.uml.edu>
Subject: Re: Switching Kernels without Rebooting?
To: riel@conectiva.com.br (Rik van Riel)
Date: Thu, 12 Jul 2001 12:23:31 -0400 (EDT)
Cc: cslater@wcnet.org (C. Slater), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33L.0107121236310.20836-100000@imladris.rielhome.conectiva> from "Rik van Riel" at Jul 12, 2001 12:39:55 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel writes:

> I won't have time to put in a project as huge and difficult
> as upgrading the kernel "live", but I'll be around to try
> and teach people about how the kernel works.

I think I see a business opportunity here.

Live upgrades require data structure conversion and other horrors.
You can't just write the code and expect it to maintain itself.
You'd need to rewrite half of it every time, for every patch level.

The 24x7 places might be willing to pay somebody to do this.
It's consulting work really. The customer says "I want to go
from 2.4.8 to 2.4.12", you say "OK, $320405 please.", and you
make a custom upgrade procedure for them.


