Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274752AbRLEP0v>; Wed, 5 Dec 2001 10:26:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280999AbRLEP0m>; Wed, 5 Dec 2001 10:26:42 -0500
Received: from t2.redhat.com ([199.183.24.243]:1780 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S274752AbRLEP0f>; Wed, 5 Dec 2001 10:26:35 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <Pine.LNX.4.40L0.0112051509500.3642-100000@lexx.infeline.org> 
In-Reply-To: <Pine.LNX.4.40L0.0112051509500.3642-100000@lexx.infeline.org> 
To: Ketil Froyn <ketil-kernel@froyn.net>
Cc: "torvalds@transmeta.com" <torvalds@transmeta.com>,
        "marcelo@conectiva.com.br" <marcelo@conectiva.com.br>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Remove bogus #include <asm/segment.h> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 05 Dec 2001 15:26:24 +0000
Message-ID: <3423.1007565984@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ketil-kernel@froyn.net said:
>  You're leaving a few empty #else statements in there. And it looks
> like you cut a line from a comment in one place.

Ah. Cutting the line from the comment I did intentionally, having removed
similar patches to changelogs. I'll check on the #else statements. Thanks for
pointing it out.

--
dwmw2


