Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263298AbSIPW7H>; Mon, 16 Sep 2002 18:59:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263310AbSIPW7H>; Mon, 16 Sep 2002 18:59:07 -0400
Received: from balthasar.nuitari.net ([216.40.249.34]:18664 "HELO
	nuitari.nuitari.net") by vger.kernel.org with SMTP
	id <S263298AbSIPW7E>; Mon, 16 Sep 2002 18:59:04 -0400
Date: Tue, 17 Sep 2002 01:18:01 -0400 (EDT)
From: Nuitari <nuitari@balthasar.nuitari.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Hi is this critical??
In-Reply-To: <Pine.LNX.4.43.0209170045080.8244-100000@cibs9.sns.it>
Message-ID: <Pine.LNX.4.44.0209170114580.20176-100000@balthasar.nuitari.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Sep 2002 venom@sns.it wrote:

> On Mon, 16 Sep 2002 jbradford@dial.pipex.com wrote:
> 
> >
> > S.M.A.R.T. is useful to prove that a drive is dying, but it is not useful to prove that it is not.
> 
> Yes, of course, and this was exaclty what was asked here in the mail
> from xavier that started this thread. The point is if S.M.A.R.T will
> advice before you see seek errors messages from the kernel or not.

It never advised me before seeing problems in the kernel (I had about 5 
drives dying running Linux machines).

It should be trivial to just grep the kernel log for the error and mail it 
to some address. 

Another way to prove a dead drive is (after a backup) to drop it some 
until it made a nice broken drive sound (a very high pitch shriek) and 
bring it to the store that sold it to you (ideally a small one as they are 
less technically challenged then big chains).



