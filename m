Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288761AbSANEuD>; Sun, 13 Jan 2002 23:50:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288760AbSANEtx>; Sun, 13 Jan 2002 23:49:53 -0500
Received: from dsl081-053-223.sfo1.dsl.speakeasy.net ([64.81.53.223]:28544
	"EHLO starship.berlin") by vger.kernel.org with ESMTP
	id <S288761AbSANEtl>; Sun, 13 Jan 2002 23:49:41 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Dan Kegel <dank@kegel.com>, "Timothy D. Witham" <wookie@osdl.org>
Subject: Re: Regression testing of 2.4.x before release?
Date: Fri, 11 Jan 2002 00:50:42 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Luigi Genoni <kernel@Expansa.sns.it>, Mike Galbraith <mikeg@wen-online.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        stp@osdl.org
In-Reply-To: <Pine.LNX.4.33.0111041955290.30596-100000@Expansa.sns.it> <1004978377.1226.22.camel@wookie-laptop.pdx.osdl.net> <3BEF6B1B.1E077ED9@kegel.com>
In-Reply-To: <3BEF6B1B.1E077ED9@kegel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16OoyR-0001DA-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On November 12, 2001 07:24 am, Dan Kegel wrote:
> At some point it might be nice to also use the STP to help
> speed gcc 3 development, too.  (I personally am really
> looking forward to the day when I can use the same compiler
> for both c++ and kernel.)

You already can, at least I can because gcc3 builds recent kernels just fine. 
IOW, it works for me.  Conservatively, it's good to keep the old compiler 
around (choose your poison) for those few apps that don't build with gcc, but 
I feel quite comfortable at the moment having gcc3 as my default.

--
Daniel
