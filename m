Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130097AbQKCAUn>; Thu, 2 Nov 2000 19:20:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130066AbQKCAUe>; Thu, 2 Nov 2000 19:20:34 -0500
Received: from ns1.SuSE.com ([202.58.118.2]:35588 "HELO ns1.suse.com")
	by vger.kernel.org with SMTP id <S130101AbQKCAUX>;
	Thu, 2 Nov 2000 19:20:23 -0500
Date: Thu, 2 Nov 2000 23:20:47 -0800 (PST)
From: James Simmons <jsimmons@suse.com>
To: Adam Huuva <sventon@easter-eggs.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Several concurrent terminals.
In-Reply-To: <3A01508E.A992B792@easter-eggs.com>
Message-ID: <Pine.LNX.4.21.0011022319131.14650-100000@euclid.oak.suse.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> We'd like to have two sets of keyboard/mouse/screen connected to the
> same computer with each set having the control and output of an
> independent X
> session each, concurrently. There might for instance be the ps/2
> keyboard and mouse and
> USB dittos. After attempting (and failing) we believe the problem is
> really one of the kernel only allowing one virtual terminal to be active
> at one time. Is this so and what can be done?

Yes it is :-( I'm actually working on this problem. See
http://linuxconsole.sourceforge.net

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
