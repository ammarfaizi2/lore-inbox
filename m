Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286521AbSAXJ7R>; Thu, 24 Jan 2002 04:59:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286750AbSAXJ7L>; Thu, 24 Jan 2002 04:59:11 -0500
Received: from mx2.elte.hu ([157.181.151.9]:38566 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S286521AbSAXJ66>;
	Thu, 24 Jan 2002 04:58:58 -0500
Date: Thu, 24 Jan 2002 12:56:09 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Rene Rebe <rene.rebe@gmx.net>
Cc: zdenek <zdenek@smetana.com>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Missing changelog to Ingo's J5 scheduler?
In-Reply-To: <20020124.105517.730550260.rene.rebe@gmx.net>
Message-ID: <Pine.LNX.4.33.0201241255240.7900-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 24 Jan 2002, Rene Rebe wrote:

> Yes. -J5 is even better here. With -J4 moving windows arround or doing
> other GUI intensive stuff was interactive for a short time (1-2
> seconds?) - and then the programm lost all interactivity (with some
> unniced gcc in the background ...). With -J5 all applications keep
> smoth even with two rebuilds (unniced) of a distribution running!

could you also compare -J5 to -J2? [use the 2.4 patch, or vanilla
2.5.3-pre4 which has J2.]

	Ingo

