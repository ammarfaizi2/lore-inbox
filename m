Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261749AbSJIO03>; Wed, 9 Oct 2002 10:26:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261755AbSJIO03>; Wed, 9 Oct 2002 10:26:29 -0400
Received: from chaos.analogic.com ([204.178.40.224]:9093 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S261749AbSJIO02>; Wed, 9 Oct 2002 10:26:28 -0400
Date: Wed, 9 Oct 2002 10:33:38 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Robert Love <rml@tech9.net>
cc: Marco Colombo <marco@esi.it>, linux-kernel@vger.kernel.org, akpm@digeo.com,
       riel@conectiva.com.br
Subject: Re: [PATCH] O_STREAMING - flag for optimal streaming I/O
In-Reply-To: <1034172868.746.3707.camel@phantasy>
Message-ID: <Pine.LNX.3.95.1021009102638.3016A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9 Oct 2002, Robert Love wrote:

> On Wed, 2002-10-09 at 10:10, Marco Colombo wrote:
> 
> > >  #define O_NOFOLLOW	0400000 /* don't follow links */
> > >  #define O_NOFOLLOW	0x20000	/* don't follow links */

Hmm. It's been a long time since I had to use octal. Since 0400000
the exact same value as 0x20000, why not use 0x20000? It's much
more common notation.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
The US military has given us many words, FUBAR, SNAFU, now ENRON.
Yes, top management were graduates of West Point and Annapolis.

