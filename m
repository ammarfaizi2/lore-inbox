Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317014AbSEWV33>; Thu, 23 May 2002 17:29:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317015AbSEWV32>; Thu, 23 May 2002 17:29:28 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:2805 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S317014AbSEWV32>; Thu, 23 May 2002 17:29:28 -0400
Date: Thu, 23 May 2002 17:29:27 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.17 /dev/ports
Message-ID: <20020523172927.A12899@devserv.devel.redhat.com>
In-Reply-To: <Pine.LNX.4.33.0205231251430.2815-100000@penguin.transmeta.com> <3CED438B.6090906@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Date: Thu, 23 May 2002 21:31:23 +0200
> From: Martin Dalecki <dalecki@evision-ventures.com>

> Slow controll means in experimental physics - controll of
> devices which don't have hard real time constrains.
>[...]
> I assume that this kind of application is what Pete was
> talking about as he was speaking about "quite frequently"
> and finally "Solaris does without it so we could as well".

I used it for I2C on VGA cards and different ISA devices,
and flash programming. Remember that though ISA went away on
desktop, embedded people still use it. It was just FYI - if you
persuade Linus to strike /dev/port down, I am not going to shed
many tears, only a little :)  It may be different for users
of languages other than C, but let them defend themselves.

-- Pete
