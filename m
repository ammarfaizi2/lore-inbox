Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315410AbSEYVXB>; Sat, 25 May 2002 17:23:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315414AbSEYVXA>; Sat, 25 May 2002 17:23:00 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:9220 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S315410AbSEYVW5>;
	Sat, 25 May 2002 17:22:57 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200205252122.g4PLMh290935@saturn.cs.uml.edu>
Subject: Re: patent on O_ATOMICLOOKUP [Re: [PATCH] loopable tmpfs (2.4.17)]
To: torvalds@transmeta.com (Linus Torvalds)
Date: Sat, 25 May 2002 17:22:43 -0400 (EDT)
Cc: wd@denx.de (Wolfgang Denk), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0205251057370.6515-100000@home.transmeta.com> from "Linus Torvalds" at May 25, 2002 11:12:03 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds writes:

> - Yes, if you go the RTLinux way, you either need to make your RT
>   kernel modules GPL'd, or you need to pay FSMlabs. Since I would
>   strongly suggest you make kernel modules GPL'd anyway, this just
>   isn't an issue. The fact that FSMlabs can get people to pay for
>   their patent is just another "tax on stupidity".

I think you misunderstand, but maybe I do...

To get a free patent license, EVERYTHING must be GPL.
Not just the real-time part! So that would be:

1. the RT microkernel (OK)
2. the RT "app"       (OK)
3. Linux itself       (OK)
4. normal Linux apps  (ouch!)
