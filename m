Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314082AbSEYIA4>; Sat, 25 May 2002 04:00:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314085AbSEYIAz>; Sat, 25 May 2002 04:00:55 -0400
Received: from gans.physik3.uni-rostock.de ([139.30.44.2]:38670 "EHLO
	gans.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id <S314082AbSEYIAx>; Sat, 25 May 2002 04:00:53 -0400
Date: Sat, 25 May 2002 10:00:52 +0200 (CEST)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Miles Lane <miles@megapathdsl.net>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.18 -- build failure -- suspend.c:1052: dereferencing pointer
 to incomplete type 
In-Reply-To: <3CEF423D.7030901@megapathdsl.net>
Message-ID: <Pine.LNX.4.33.0205250957360.2181-100000@gans.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 May 2002, Miles Lane wrote:

> Tim wrote:
>  > I have not yet analyzed why I don't get this failunre, but does the
>  > following patch fix it for you?
> 
> Nope.  The builds still fails with the same errors.
> I will send you my entire .config file in private mail,
> since the list likely doesn't want to see the whole thing.

After looking into this a little bit deeper, I indeed see it has nothing 
to do with mit sched.h cleanups which I suspected first.

So I'm sorry I can't help you.

Tim


