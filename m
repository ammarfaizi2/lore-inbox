Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131175AbRCWO5J>; Fri, 23 Mar 2001 09:57:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131194AbRCWO4t>; Fri, 23 Mar 2001 09:56:49 -0500
Received: from zmamail05.zma.compaq.com ([161.114.64.105]:49676 "HELO
	zmamail05.zma.compaq.com") by vger.kernel.org with SMTP
	id <S131175AbRCWO4i>; Fri, 23 Mar 2001 09:56:38 -0500
Reply-To: <frey@cxau.zko.dec.com>
From: "Martin Frey" <frey@scs.ch>
To: "'Andrew Morton'" <andrewm@uow.edu.au>
Cc: "'Benjamin Herrenschmidt'" <benh@kernel.crashing.org>,
        <linux-kernel@vger.kernel.org>
Subject: RE: kernel_thread vs. zombie
Date: Fri, 23 Mar 2001 00:06:56 -0800
Message-ID: <009e01c0b3a9$54a3cdc0$90600410@SCHLEPPDOWN>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <3ABAB12D.CE7FA890@uow.edu.au>
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6700
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>So I think it's reasonable to use keventd as `kinit', if you like.
>Something which knows how to launch and reap kernel daemons, and
>which provides a known environment to them.
>
>A kernel API function (`kernel_daemon'?) which does all this
>boilerplate is needed, I think.
>
I completely agree. I'll be on a trip for the next two weeks, but
after that I can write a small example how it would look. I'll mail
again when it is ready.

Thanks, Martin
