Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284890AbRLZUmq>; Wed, 26 Dec 2001 15:42:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284899AbRLZUmg>; Wed, 26 Dec 2001 15:42:36 -0500
Received: from dsl-213-023-038-250.arcor-ip.net ([213.23.38.250]:11283 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S284890AbRLZUmW>;
	Wed, 26 Dec 2001 15:42:22 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Bill Huey <billh@tierra.ucsd.edu>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Java and Flam^H^H^H^H AIO (was: aio)
Date: Wed, 26 Dec 2001 21:42:40 +0100
X-Mailer: KMail [version 1.3.2]
Cc: "David S. Miller" <davem@redhat.com>, billh@tierra.ucsd.edu,
        bcrl@redhat.com, torvalds@transmeta.com, linux-kernel@vger.kernel.org,
        linux-aio@kvack.org
In-Reply-To: <20011219.172046.08320763.davem@redhat.com> <E16HTTI-0000w0-00@the-village.bc.nu> <20011222214630.B12352@burn.ucsd.edu>
In-Reply-To: <20011222214630.B12352@burn.ucsd.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16JKsv-0000bc-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On December 23, 2001 06:46 am, Bill Huey wrote:
> On Fri, Dec 21, 2001 at 05:28:36PM +0000, Alan Cox wrote:
> > > Precisely, in fact.  Anyone who can say that Java is going to be
> > > relevant in a few years time, with a straight face, is only kidding
> > > themselves.
> > 
> > Oh it'll be very relevant. Its leaking into all sorts of embedded uses,
> > from Digital TV to smartcards. Its still useless for serious high end 
> > work an likely to stay so.
> > 
> > > Java is not something to justify a new kernel feature, that is for
> > > certain.
> > 
> > There we agree. Things like the current asynch/thread mess in java are
> > partly poor design of language and greatly stupid design of JVM.
> 
> It's not the fault of the JVM runtime nor the the language per se since
> both are excellent. The blame should instead be placed on the political
> process within Sun, which has created a lag in getting a decent IO event
> model/system available in the form of an API.

Hey wait, it can't be so.  Sun apparently uses a boot camp system to 
guarantee that every project finishes on time, every time. 

* daniel ducks and runs

--
Daniel

