Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263121AbTJPTU0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 15:20:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263122AbTJPTU0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 15:20:26 -0400
Received: from chaos.analogic.com ([204.178.40.224]:11136 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S263121AbTJPTUZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 15:20:25 -0400
Date: Thu, 16 Oct 2003 15:20:21 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: John Bradford <john@grabjohn.com>
cc: Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org, val@nmt.edu
Subject: Re: Transparent compression in the FS
In-Reply-To: <200310161903.h9GJ3r6r002059@81-2-122-30.bradfords.org.uk>
Message-ID: <Pine.LNX.4.53.0310161514330.1006@chaos>
References: <1066163449.4286.4.camel@Borogove> <20031015133305.GF24799@bitwizard.nl>
 <3F8D6417.8050409@pobox.com> <20031016162926.GF1663@velociraptor.random>
 <Pine.LNX.4.53.0310161453240.814@chaos> <200310161903.h9GJ3r6r002059@81-2-122-30.bradfords.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Oct 2003, John Bradford wrote:

> Quote from "Richard B. Johnson" <root@chaos.analogic.com>:
> > No! Not true. 'lossy' means that you can't recover the original
> > data. Some music compression and video compression schemes are
> > lossy. If you can get back the exact input data, it's not lossy.
>
> Sorry, I wasn't clear in my description.  What I meant was that you
> can't have an algorithm that can compress all possible values of N
> bits in to less than N bits, without expanding some of them.  Of
> course, you can compress N values in to <N values, compressors do that
> by definition :-)
>
> John.
>

Ahha. Yes you are provably correct unless you use some additional
"message-channel" to cheat.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


