Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129956AbQLKTZn>; Mon, 11 Dec 2000 14:25:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129983AbQLKTZd>; Mon, 11 Dec 2000 14:25:33 -0500
Received: from va-ext.webmethods.com ([208.234.160.252]:16224 "EHLO
	localhost.neuron.com") by vger.kernel.org with ESMTP
	id <S129956AbQLKTZN>; Mon, 11 Dec 2000 14:25:13 -0500
Date: Mon, 11 Dec 2000 13:56:22 -0500 (EST)
From: stewart@neuron.com
To: Rik van Riel <riel@conectiva.com.br>
cc: linux-kernel@vger.kernel.org
Subject: Re: kapm-idled : is this a bug?
In-Reply-To: <Pine.LNX.4.21.0012111315350.4808-100000@duckman.distro.conectiva>
Message-ID: <Pine.LNX.4.10.10012111343570.2897-100000@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


very helpful.

Technical merits and voter intent aside, this behavior is misleading and
inconsistent with previous kernels. Tools like top or a CPU dock applet show
a constantly loaded CPU. Hacking them to deduct the load from 'kapm-idled'
seems like the wrong answer.

stewart


On Mon, 11 Dec 2000, Rik van Riel wrote:

> On Mon, 11 Dec 2000 stewart@neuron.com wrote:
> 
> 	[snip whine]
> 
> >  I've consistently re-produced this on my Dell Latitude CS laptop. I'm
> >  wondering if this will reduce battery life since the CPU is constantly
> >  being loaded instead of properly idled.
> 
> What do you suppose the 'idled' in 'kapm-idled' stands for?
> 
> Rik




-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
