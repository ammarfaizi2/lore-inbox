Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261663AbRESGez>; Sat, 19 May 2001 02:34:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261664AbRESGeo>; Sat, 19 May 2001 02:34:44 -0400
Received: from [203.143.19.4] ([203.143.19.4]:59657 "EHLO kitul.learn.ac.lk")
	by vger.kernel.org with ESMTP id <S261663AbRESGec>;
	Sat, 19 May 2001 02:34:32 -0400
Date: Fri, 18 May 2001 16:41:16 +0600 (LKT)
From: Anuradha Ratnaweera <anuradha@gnu.org>
To: Lorenzo Marcantonio <lorenzo.marcantonio@sinfopragma.it>
cc: "H. Peter Anvin" <hpa@transmeta.com>, root@chaos.analogic.com,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux-2.4.4 failure to compile
In-Reply-To: <Pine.WNT.4.31.0105180827380.65-100000@pc209.sinfopragma.it>
Message-ID: <Pine.LNX.4.21.0105181638000.251-100000@presario>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 18 May 2001, Lorenzo Marcantonio wrote:

> On Thu, 17 May 2001, H. Peter Anvin wrote:
> 
> > I think the header file you're talking about is the db1 header file,
> > which has nothing to do with yacc -- it's the Berkeley libdb version 1,
> > which is a pretty bad thing to require.
> >
> 
> I've got it to compile (and apparently work) even con libdb3... which
> has the compability header db_185.h (or something similar).
> 
> IIRC, libdb1 was bundled with libc till release 2.1.3. Since 2.2 they've
> said 'get it at sleepycat...'.
> 
> BTW, there are ifdef inside the driver about which header to include
> (db.h or db_185.h IIRC).
> 
> I still doesn't comprend what does it NEED FOR the libdb...

I don't do any module programming yet, but the lkmpg lists "Using standard
libraries" under "Common Pitfalls". Is anything unusual going on here?

Anuradha

----------------------------------
http://www.bee.lk/people/anuradha/

