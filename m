Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318741AbSHQVhX>; Sat, 17 Aug 2002 17:37:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318743AbSHQVhX>; Sat, 17 Aug 2002 17:37:23 -0400
Received: from mx1.elte.hu ([157.181.1.137]:11174 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S318741AbSHQVhW>;
	Sat, 17 Aug 2002 17:37:22 -0400
Date: Sat, 17 Aug 2002 23:42:21 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Gabriel Paubert <paubert@iram.es>,
       James Bottomley <James.Bottomley@HansenPartnership.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Boot failure in 2.5.31 BK with new TLS patch
In-Reply-To: <Pine.LNX.4.44.0208172051280.17227-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0208172342120.16866-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 17 Aug 2002, Ingo Molnar wrote:

> oh, setup.S. nasty indeed. (yet) untested patch attached, booting into
> the new kernel shortly.

works for me.

	Ingo

