Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262726AbSI1EzW>; Sat, 28 Sep 2002 00:55:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262727AbSI1EzW>; Sat, 28 Sep 2002 00:55:22 -0400
Received: from sex.inr.ac.ru ([193.233.7.165]:64708 "HELO sex.inr.ac.ru")
	by vger.kernel.org with SMTP id <S262726AbSI1EzW>;
	Sat, 28 Sep 2002 00:55:22 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200209280500.JAA02974@sex.inr.ac.ru>
Subject: Re: [PATCH] IPv6: Improvement of Source Address Selection
To: pekkas@netcore.fi (Pekka Savola)
Date: Sat, 28 Sep 2002 09:00:08 +0400 (MSD)
Cc: davem@redhat.com, yoshfuji@linux-ipv6.org, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com, usagi@linux-ipv6.org
In-Reply-To: <Pine.LNX.4.44.0209280726010.8405-100000@netcore.fi> from "Pekka Savola" at Sep 28, 2 07:35:57 am
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> Isn't putting this logic to routes an oversimplification?

Hmmm... I believed this logic is more complicated yet. :-)


> route, as there would have to be at least two candidates there.
...
> Am I missing something obvious here?

Yes. You select some one of the candidates eventually, do not you? :-)
And when you have some special preference for a subnet you create
a route for it.

> (stuff that's network prefix -independent

I am sorry, I feel I do not understand what you mean.

Alexey
