Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286163AbRLJFlP>; Mon, 10 Dec 2001 00:41:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286164AbRLJFlE>; Mon, 10 Dec 2001 00:41:04 -0500
Received: from sydney1.au.ibm.com ([202.135.142.193]:25354 "EHLO wagner")
	by vger.kernel.org with ESMTP id <S286163AbRLJFk5>;
	Mon, 10 Dec 2001 00:40:57 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, anton@samba.org, davej@suse.de,
        marcelo@conectiva.com.br, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
Subject: Re: Linux 2.4.17-pre5 
In-Reply-To: Your message of "Sun, 09 Dec 2001 18:10:23 -0800."
             <2899076331.1007921423@[10.10.1.2]> 
Date: Mon, 10 Dec 2001 16:40:50 +1100
Message-Id: <E16DJBK-0002BT-00@wagner>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <2899076331.1007921423@[10.10.1.2]> you write:
> On the other hand, relying on the "arbitrary" cpu numbers either way doesn't
> seem like the best of ideas ;-)

Well, putting a comment in reschedule_idle() saying "we fill from the
bottom, and some ports rely on this" might be nice 8)

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
