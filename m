Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129562AbQJaWwN>; Tue, 31 Oct 2000 17:52:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129636AbQJaWwC>; Tue, 31 Oct 2000 17:52:02 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:24843 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S129562AbQJaWvp>; Tue, 31 Oct 2000 17:51:45 -0500
Message-ID: <39FF4C1C.E16A0669@timpanogas.org>
Date: Tue, 31 Oct 2000 15:47:56 -0700
From: "Jeff V. Merkey" <jmerkey@timpanogas.org>
Organization: TRG, Inc.
X-Mailer: Mozilla 4.7 [en] (WinNT; I)
X-Accept-Language: en
MIME-Version: 1.0
To: mingo@elte.hu
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.2.18Pre Lan Performance Rocks!
In-Reply-To: <Pine.LNX.4.21.0011010040030.17233-100000@elte.hu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Ingo Molnar wrote:
> 
> On Tue, 31 Oct 2000, Jeff V. Merkey wrote:
> 
> > A "context" is usually assued to be a "stack". [...]
> 
> a very clintonesque definition indeed ;-)
> 
> what is relevant is the latency to switch from one process to another one.
> And this is what we call a context switch. It includes scheduling
> decisions and all sorts of other stuff. You are comparing stack &
> caller-saved register switching performance (which is just a small part of
> context switching and has no standing alone) against full Linux context
> switch performance (this is what i quoted), and thus you have won my
> 'Mindcraft benchmark of the day' award :-)

Ingo,

It kicks Linux's but in LAN I/O scaling.  It would be nice for Linux to
have an incarnation that's competitive.  The only reason people are
still buying NetWare is because nothing out there has come along to
replace it.  That is going to change...

Jeff 


> 
>         Ingo
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
