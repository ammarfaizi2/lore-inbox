Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266056AbRF1Rhf>; Thu, 28 Jun 2001 13:37:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266058AbRF1RhZ>; Thu, 28 Jun 2001 13:37:25 -0400
Received: from t2.redhat.com ([199.183.24.243]:14066 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S266056AbRF1RhN>; Thu, 28 Jun 2001 13:37:13 -0400
X-Mailer: exmh version 2.3 01/15/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <Pine.LNX.4.33.0106281024160.15199-100000@penguin.transmeta.com> 
In-Reply-To: <Pine.LNX.4.33.0106281024160.15199-100000@penguin.transmeta.com> 
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, chuckw@altaserv.net,
        Vipin Malik <vipin.malik@daniel.com>,
        Aaron Lehmann <aaronl@vitelus.com>, jffs-dev@axis.com,
        linux-kernel@vger.kernel.org
Subject: Re: Cosmetic JFFS patch. 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 28 Jun 2001 18:35:40 +0100
Message-ID: <7953.993749740@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


torvalds@transmeta.com said:
> On Thu, 28 Jun 2001, Alan Cox wrote: 
> > Managers at places like Cisco see boot messages and it gets into
> > their brains. They certainly don't all read the source code.

> Quote frankly, I doubt "managers" read the boot messages. 

This is consistent with what Alan said. "read" != "see".

I agree the messages can be ugly. But they don't do any harm either, and 
sometimes they're useful.

Furthermore, I believe that if you enforce a policy of removing them, the
direct result of that will be that GPL'd code is released back into the
community far slower than it is at the moment.

It's your choice, though.

--
dwmw2


