Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130507AbRACWLI>; Wed, 3 Jan 2001 17:11:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130338AbRACWK6>; Wed, 3 Jan 2001 17:10:58 -0500
Received: from [216.151.155.116] ([216.151.155.116]:17925 "EHLO
	belphigor.mcnaught.org") by vger.kernel.org with ESMTP
	id <S130111AbRACWKs>; Wed, 3 Jan 2001 17:10:48 -0500
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] prevention of syscalls from writable segments, breaking bug exploits
In-Reply-To: <Pine.LNX.4.30.0101031406160.31664-100000@anime.net>
From: Doug McNaught <doug@wireboard.com>
Date: 03 Jan 2001 17:10:43 -0500
In-Reply-To: Dan Hollis's message of "Wed, 3 Jan 2001 14:07:14 -0800 (PST)"
Message-ID: <m34rzgl21o.fsf@belphigor.mcnaught.org>
User-Agent: Gnus/5.0806 (Gnus v5.8.6) XEmacs/21.1 (20 Minutes to Nikko)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Hollis <goemon@anime.net> writes:

> On Wed, 3 Jan 2001, Alexander Viro wrote:
> > On Wed, 3 Jan 2001, Dan Aloni wrote:
> > > without breaking anything. It also reports of such calls by using printk.
> > Get real.
> 
> Why do you always have to be insulting alex? Sheesh.

I was thinking it's about time this flamewar^Wthread came up again.
Shall we start a pool on total # of messages, first invocation of
Godwin's law, etc?

-Doug
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
