Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280738AbRKLRFz>; Mon, 12 Nov 2001 12:05:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280840AbRKLRFq>; Mon, 12 Nov 2001 12:05:46 -0500
Received: from posta2.elte.hu ([157.181.151.9]:38796 "HELO posta2.elte.hu")
	by vger.kernel.org with SMTP id <S280738AbRKLRFe>;
	Mon, 12 Nov 2001 12:05:34 -0500
Date: Mon, 12 Nov 2001 19:03:25 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Tux mailing list <tux-list@redhat.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Error starting TUX - URGENT - Please help
In-Reply-To: <Pine.LNX.4.30.0111121601570.28182-100000@mustard.heime.net>
Message-ID: <Pine.LNX.4.33.0111121902380.16755-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> TUX: logger thread started.
> TUX: thread 0 listens on http://0.0.0.0:80.
> TUX: could not start worker thread 1.

i've uploaded the -B1 patch to:

	http://redhat.com/~mingo/TUX-patches/

it has this bug fixed,

	Ingo

