Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265820AbRFYAbi>; Sun, 24 Jun 2001 20:31:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265822AbRFYAb2>; Sun, 24 Jun 2001 20:31:28 -0400
Received: from [216.21.153.1] ([216.21.153.1]:43534 "HELO innerfire.net")
	by vger.kernel.org with SMTP id <S265819AbRFYAbO>;
	Sun, 24 Jun 2001 20:31:14 -0400
Date: Sun, 24 Jun 2001 17:32:46 -0700 (PDT)
From: Gerhard Mack <gmack@innerfire.net>
To: "J . A . Magallon" <jamagallon@able.es>
cc: Larry McVoy <lm@bitmover.com>, landley@webofficenow.com,
        Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
        Timur Tabi <ttabi@interactivesi.com>,
        "linux-kernel @ vger . kernel . org" <linux-kernel@vger.kernel.org>
Subject: Re: Alan Cox quote? (was: Re: accounting for threads)
In-Reply-To: <20010625020530.A10509@werewolf.able.es>
Message-ID: <Pine.LNX.4.10.10106241726460.14567-100000@innerfire.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> BTW, after all I have read all POSIX threads library should be no more than
> a wrapper over fork(), clone and so on. Why are they so bad then ?
> I am going to get glibc source to see what is inside pthread_create...

If I recall it had to do with problems in signal delivery...



--
Gerhard Mack

gmack@innerfire.net

<>< As a computer I find your faith in technology amusing.

