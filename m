Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286314AbRLTSVt>; Thu, 20 Dec 2001 13:21:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286315AbRLTSVp>; Thu, 20 Dec 2001 13:21:45 -0500
Received: from ns01.netrox.net ([64.118.231.130]:27641 "EHLO smtp01.netrox.net")
	by vger.kernel.org with ESMTP id <S286314AbRLTSV1>;
	Thu, 20 Dec 2001 13:21:27 -0500
Subject: Re: aio
From: Robert Love <rml@tech9.net>
To: mingo@elte.hu
Cc: Linus Torvalds <torvalds@transmeta.com>,
        "David S. Miller" <davem@redhat.com>, bcrl@redhat.com, cs@zip.com.au,
        billh@tierra.ucsd.edu, linux-kernel@vger.kernel.org,
        linux-aio@kvack.org
In-Reply-To: <Pine.LNX.4.33.0112201101580.2464-100000@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.33.0112201101580.2464-100000@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.0.99+cvs.2001.12.18.08.57 (Preview Release)
Date: 20 Dec 2001 13:20:55 -0500
Message-Id: <1008872459.2777.10.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2001-12-20 at 05:18, Ingo Molnar wrote:

> there are two possibilities i can think of:
> 
> 1) lets get Ben's patch in but do *not* export the syscalls, yet.

This is an excellent way to give aio the testing and exposure Linus
wants without getting into the commitment / syscall mess.

Stick aio in the kernel, play with it via Tux, etc.  The really
interested can add temporary syscalls.  aio (which I like, btw) will get
testing and in time, once proven, we can add the syscalls.

Comments?

	Robert Love

