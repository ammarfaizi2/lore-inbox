Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317096AbSHYKLq>; Sun, 25 Aug 2002 06:11:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317101AbSHYKLq>; Sun, 25 Aug 2002 06:11:46 -0400
Received: from c16598.thoms1.vic.optusnet.com.au ([210.49.243.217]:24013 "HELO
	pc.kolivas.net") by vger.kernel.org with SMTP id <S317096AbSHYKLp>;
	Sun, 25 Aug 2002 06:11:45 -0400
Message-ID: <1030270557.3d68ae5dd2b04@kolivas.net>
Date: Sun, 25 Aug 2002 20:15:57 +1000
From: conman@kolivas.net
To: Paul Drain <pd@cipherfunk.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.19 kernel patches - any chance of a seperation?
References: <1030171275.7728.83.camel@tickle-me-elmo.int.ridge.com.au>  <1030171550.3d672b9e0a17f@kolivas.net> <1030173093.30956.97.camel@tickle-me-elmo.int.ridge.com.au>
In-Reply-To: <1030173093.30956.97.camel@tickle-me-elmo.int.ridge.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Paul Drain <pd@cipherfunk.org>:
> What I was looking to do is just take:
> 
> - O1+ck
> - preempt+ck
> 
> and
> 
> - rmap+ck (and merge the other slab based cleanups i've yet to push to
> Rik and co.) 
> 
> and drop those in as 000- individual patches. (if you look in
> ftp://cipherfunk.org/pub/kernels/v2.4/individual/2.4.19/fnk4/ you'll see
> an individually seperated set of patches that form my -fnk4 patch)

Ask and ye shall receive. Incremental patches are now available for download :)
http://kernel.kolivas.net

Cheers,
Con Kolivas
