Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274990AbRKHQFW>; Thu, 8 Nov 2001 11:05:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274813AbRKHQFN>; Thu, 8 Nov 2001 11:05:13 -0500
Received: from posta2.elte.hu ([157.181.151.9]:16360 "HELO posta2.elte.hu")
	by vger.kernel.org with SMTP id <S274434AbRKHQFB>;
	Thu, 8 Nov 2001 11:05:01 -0500
Date: Thu, 8 Nov 2001 18:02:56 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: speed difference between using hard-linked and modular drives?
In-Reply-To: <Pine.LNX.4.30.0111081700240.1916-100000@mustard.heime.net>
Message-ID: <Pine.LNX.4.33.0111081802380.15975-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 8 Nov 2001, Roy Sigurd Karlsbakk wrote:

> Are there any speed difference between hard-linked device drivers and
> their modular counterparts?

minimal. a few instructions per IO.

	Ingo

