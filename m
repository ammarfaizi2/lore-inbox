Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131341AbRCXAWR>; Fri, 23 Mar 2001 19:22:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131346AbRCXAV5>; Fri, 23 Mar 2001 19:21:57 -0500
Received: from richard2.pil.net ([207.8.164.9]:4616 "HELO richard2.pil.net")
	by vger.kernel.org with SMTP id <S131341AbRCXAVy>;
	Fri, 23 Mar 2001 19:21:54 -0500
Date: Fri, 23 Mar 2001 19:21:23 -0500 (EST)
From: Tom Diehl <tdiehl@pil.net>
To: Tim Wright <timw@splhi.com>
Cc: Rik van Riel <riel@conectiva.com.br>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Prevent OOM from killing init
In-Reply-To: <20010323155600.A2534@kochanski.internal.splhi.com>
Message-ID: <Pine.LNX.4.30.0103231920490.22434-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Mar 2001, Tim Wright wrote:

> Netscape 4 has some very nasty habits like suddenly consuming ~80MB of memory.
> Disabling java support seems to eradicate most occurences of this particularly
> obnoxious behaviour. Under these circumstances, the OOM killer is doing exactly
> the right thing i.e. killing a runaway app.

Thanks for the info. I sus[ected as much but I was not sure.

-- 
......Tom	ATA100 is another testimony to the fact that pigs can be
tdiehl@pil.net	made to fly given sufficient thrust (to borrow an RFC)
		Alan Cox lkml 11 Jan 01

