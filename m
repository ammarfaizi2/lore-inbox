Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318264AbSHZT0s>; Mon, 26 Aug 2002 15:26:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318269AbSHZT0s>; Mon, 26 Aug 2002 15:26:48 -0400
Received: from mx1.elte.hu ([157.181.1.137]:36586 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S318264AbSHZT0r>;
	Mon, 26 Aug 2002 15:26:47 -0400
Date: Mon, 26 Aug 2002 21:33:58 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Robert Love <rml@tech9.net>
Cc: Pavel Machek <pavel@elf.ucw.cz>, Linus Torvalds <torvalds@transmeta.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [patch] clone-detached-2.5.31-B0
In-Reply-To: <1030390106.15007.306.camel@phantasy>
Message-ID: <Pine.LNX.4.44.0208262132250.7997-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Ingo has said previously that he does not like the syntax of BUG_ON.

well, meanwhile BUG_ON() is being used quite extensively, so i'd rather
have global consistency than different coding styles. I'll fix these
places in an upcoming patch.

	Ingo

