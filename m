Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135985AbREAH1E>; Tue, 1 May 2001 03:27:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136585AbREAH0q>; Tue, 1 May 2001 03:26:46 -0400
Received: from chiara.elte.hu ([157.181.150.200]:18700 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S136582AbREAH0l>;
	Tue, 1 May 2001 03:26:41 -0400
Date: Tue, 1 May 2001 09:25:07 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Fabio Riccardi <fabio@chromium.com>
Cc: <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Christopher Smith <x@xman.org>, Andrew Morton <andrewm@uow.edu.au>,
        "Timothy D. Witham" <wookie@osdlab.org>, <David_J_Morse@Dell.com>
Subject: Re: X15 alpha release: as fast as TUX but in user space
In-Reply-To: <3AEC86B7.119362D9@chromium.com>
Message-ID: <Pine.LNX.4.33.0105010924190.3473-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 29 Apr 2001, Fabio Riccardi wrote:

> I can disable header caching and see what happens, I'll add an option
> for this in the next X15 release.

what SPECweb99 performance do you get if you disable header caching? It
might not make all that much of a difference. (but it will make the
results more comparable with TUX.)

	Ingo

