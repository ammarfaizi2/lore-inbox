Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286904AbSASSlp>; Sat, 19 Jan 2002 13:41:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286925AbSASSlf>; Sat, 19 Jan 2002 13:41:35 -0500
Received: from minus.inr.ac.ru ([193.233.7.97]:20754 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S286904AbSASSla>;
	Sat, 19 Jan 2002 13:41:30 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200201191841.VAA31776@ms2.inr.ac.ru>
Subject: Re: Oops in sock_poll
To: davem@redhat.COM (David S. Miller)
Date: Sat, 19 Jan 2002 21:41:21 +0300 (MSK)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020118.025554.133432828.davem@redhat.com> from "David S. Miller" at Jan 18, 2 02:15:00 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

>    The kernel used is customized in many ways, it is a long work to upgrade
> 
> Then I can't help you... there have probably been many
> networking bugs fixed since 2.4.9

I do not remember that we _ever_ had problems with leaking f_count.
And it is so far of networking... :-)

"customized in many ways" bug sounds as better candidate to be fixed.

Alexey
