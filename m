Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261495AbTAOENk>; Tue, 14 Jan 2003 23:13:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265681AbTAOENj>; Tue, 14 Jan 2003 23:13:39 -0500
Received: from [64.8.50.184] ([64.8.50.184]:38892 "EHLO mta4.adelphia.net")
	by vger.kernel.org with ESMTP id <S261495AbTAOENj>;
	Tue, 14 Jan 2003 23:13:39 -0500
Message-ID: <3029.10.1.0.252.1042604546.squirrel@webmail.laufernet.com>
Date: Tue, 14 Jan 2003 20:22:26 -0800 (PST)
Subject: Re: [PATCH] 2.5.58 sound/isa/sb/sb16.c isapnp compile
From: <paul@laufernet.com>
To: <matt@mh.dropbear.id.au>
In-Reply-To: <20030115043417.GA12493@mh.dropbear.id.au>
References: <20030115043417.GA12493@mh.dropbear.id.au>
X-Priority: 3
Importance: Normal
X-MSMail-Priority: Normal
Cc: <linux-kernel@vger.kernel.org>
X-Mailer: SquirrelMail (version 1.2.6)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have rewritten sb_card.c for use with the new pnp and modules interface.
I'll get you a copy soon, my ISP has gone out of business and I've been
without access for a few weeks now.
I have also a patch to the rest of the oss soundblaster driver to make it
use safe interfaces so that it can be unloaded.
Paul

Matthew Hawkins said:
> Here's a patch based on an earlier one by Ruslan Zakirov
> to get the sb16 driver to compile again wrt. isapnp changes.
>
> Now, if someone could get it to _work_ I'd be grateful ;)
>
> Cheers,
>
> --
> Matt



