Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270794AbRHNVen>; Tue, 14 Aug 2001 17:34:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270851AbRHNVee>; Tue, 14 Aug 2001 17:34:34 -0400
Received: from anime.net ([63.172.78.150]:15377 "EHLO anime.net")
	by vger.kernel.org with ESMTP id <S270794AbRHNVeY>;
	Tue, 14 Aug 2001 17:34:24 -0400
Date: Tue, 14 Aug 2001 14:32:40 -0700 (PDT)
From: Dan Hollis <goemon@anime.net>
To: Chris Crowther <chrisc@shad0w.org.uk>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] CDP handler for linux
In-Reply-To: <Pine.LNX.4.33.0108142137300.3810-100000@monolith.shad0w.org.uk>
Message-ID: <Pine.LNX.4.30.0108141429040.31529-100000@anime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Aug 2001, Chris Crowther wrote:
> either - it just sits there, collecting and sending information.  The only
> thing you would really need in userspace, would be tools to read
> information from the cdp handler if you wanted to do more than just look
> at the neighbor summary.  I can't see any real advantages of running it as
> a daemon as opposed to a kernel component.

Except that as userspace daemon if cdpd goes splat the kernel generally
doesnt go splat either.

-Dan

-- 
[-] Omae no subete no kichi wa ore no mono da. [-]

