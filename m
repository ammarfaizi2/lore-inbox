Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287145AbSBCNf6>; Sun, 3 Feb 2002 08:35:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287177AbSBCNfr>; Sun, 3 Feb 2002 08:35:47 -0500
Received: from mx2.elte.hu ([157.181.151.9]:18883 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S287145AbSBCNfi>;
	Sun, 3 Feb 2002 08:35:38 -0500
Date: Sun, 3 Feb 2002 16:33:17 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Steffen Persvold <sp@scali.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Short question regarding generic_make_request()
In-Reply-To: <3C5D3BC9.CA9E24A@scali.com>
Message-ID: <Pine.LNX.4.33.0202031632580.11943-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 3 Feb 2002, Steffen Persvold wrote:

> Can generic_make_request() be called from interrupt level (or tasklet)
> ?

no.

	Ingo

