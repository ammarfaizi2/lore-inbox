Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274218AbRISWN7>; Wed, 19 Sep 2001 18:13:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274220AbRISWNt>; Wed, 19 Sep 2001 18:13:49 -0400
Received: from anime.net ([63.172.78.150]:12805 "EHLO anime.net")
	by vger.kernel.org with ESMTP id <S274218AbRISWNk>;
	Wed, 19 Sep 2001 18:13:40 -0400
Date: Wed, 19 Sep 2001 15:13:55 -0700 (PDT)
From: Dan Hollis <goemon@anime.net>
To: "Eric W. Biederman" <ebiederm@xmission.com>
cc: Arjan van de Ven <arjanv@redhat.com>, Petr Vandrovec <VANDROVE@vc.cvut.cz>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Athlon bug stomper. Pls apply.
In-Reply-To: <m1adzqg8j6.fsf@frodo.biederman.org>
Message-ID: <Pine.LNX.4.30.0109191509480.29421-100000@anime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 19 Sep 2001, Eric W. Biederman wrote:
> Of course VIA looking at what they have done and what that bit is
> supposed to be is easiest as they have the schemantics of those
> chips.  But there is not reason to be limited to just that approach.

Testing it is ok, its rolling the "patch" into production kernels that im
most concerned about.

What happens if the bit happens to fiddle with motherboard voltages and
you end up destroying peoples hardware...

Until we have a straight answer what the hell this bit does, its a very
bad idea to put it into *production kernel*.

We definitely need more data points too. So far we dont have any athlon.c
data for kt133a with the bit on and off, only kt133.

-Dan

-- 
[-] Omae no subete no kichi wa ore no mono da. [-]

