Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287656AbSAMS6r>; Sun, 13 Jan 2002 13:58:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288019AbSAMS61>; Sun, 13 Jan 2002 13:58:27 -0500
Received: from mx2.elte.hu ([157.181.151.9]:44420 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S287656AbSAMS6Q>;
	Sun, 13 Jan 2002 13:58:16 -0500
Date: Sun, 13 Jan 2002 21:55:37 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: "James C. Owens" <owensjc@bellatlantic.net>
Cc: "'Matti Aarnio'" <matti.aarnio@zmailer.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: O(1) scheduler ver H6 - more straightforward timeslice macros
In-Reply-To: <000001c19c62$11882e30$0100a8c0@jcowens.net>
Message-ID: <Pine.LNX.4.33.0201132154590.9509-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 13 Jan 2002, James C. Owens wrote:

> I agree they are not quite equivalent. I have to point out that your
> macro definition never delivers max timeslice for the valid nice
> range. [...]

agreed - i took your macro definitions and they are in my tree already.
Good work and thanks!

	Ingo

