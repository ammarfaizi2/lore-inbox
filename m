Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318891AbSIIUtr>; Mon, 9 Sep 2002 16:49:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318892AbSIIUtr>; Mon, 9 Sep 2002 16:49:47 -0400
Received: from mx1.elte.hu ([157.181.1.137]:19873 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S318891AbSIIUtp>;
	Mon, 9 Sep 2002 16:49:45 -0400
Date: Mon, 9 Sep 2002 22:58:15 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Daniel Jacobowitz <dan@debian.org>
Cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: do_syslog/__down_trylock lockup in current BK
In-Reply-To: <20020909204026.GA8719@nevyn.them.org>
Message-ID: <Pine.LNX.4.44.0209092258050.26702-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


some more info about the state it was in:

p (ld-linux.so.2, 4364/4357), father: (ld-linux.so.2, 4363/4357)
kernel BUG at exit.c:470!

	Ingo

