Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319098AbSHMSTp>; Tue, 13 Aug 2002 14:19:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319097AbSHMSSh>; Tue, 13 Aug 2002 14:18:37 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:31246 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S319096AbSHMSS3>; Tue, 13 Aug 2002 14:18:29 -0400
Date: Tue, 13 Aug 2002 11:24:43 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ingo Molnar <mingo@elte.hu>
cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] exit_free(), 2.5.31-A0
In-Reply-To: <Pine.LNX.4.44.0208132009390.5990-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0208131123480.7411-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 13 Aug 2002, Ingo Molnar wrote:
> 
> I was actually surprised to see how much effort it takes on the glibc side
> to solve this (admittedly conceptually hard) problem without any kernel
> help - it's ugly and slow, and still not completely tight. By providing
> this 'exit and free stack' capability we can help tremendously.

Ingo, you're barking up the wrong tree.

I'm not against fixing it, but I'm very much against fixing it wrong.

I even told you how you can fix it right. You're arguing against the wrong 
thing here.

		Linus

