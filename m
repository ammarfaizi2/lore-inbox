Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277090AbRJDCcH>; Wed, 3 Oct 2001 22:32:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277091AbRJDCb6>; Wed, 3 Oct 2001 22:31:58 -0400
Received: from femail40.sdc1.sfba.home.com ([24.254.60.34]:37602 "EHLO
	femail40.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S277090AbRJDCbn>; Wed, 3 Oct 2001 22:31:43 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
Reply-To: landley@trommello.org
Organization: Boundaries Unlimited
To: Benjamin LaHaise <bcrl@redhat.com>
Subject: Re: [announce] [patch] limiting IRQ load, irq-rewrite-2.4.11-B5
Date: Wed, 3 Oct 2001 18:31:30 -0400
X-Mailer: KMail [version 1.2]
In-Reply-To: <20011003150355.A3780@redhat.com> <Pine.GSO.4.30.0110032105150.8016-100000@shell.cyberus.ca> <20011003213010.F3780@redhat.com>
In-Reply-To: <20011003213010.F3780@redhat.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-Id: <01100318313002.00728@localhost.localdomain>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 03 October 2001 21:30, Benjamin LaHaise wrote:
> On Wed, Oct 03, 2001 at 09:10:10PM -0400, jamal wrote:
> > > Well, this sounds like a 2.5 patch.  When do we get to merge it?
> >
> > It is backward compatible to 2.4 netif_rx() which means it can go in now.
> > The problem is netdrivers that want to use the interface have to be
> > morphed.
>
> I'm alluding to the fact that we need a place to put in-development
> patches.

Such as a 2.5 kernel tree? :)

Sorry, couldn't resist.  It was just hanging there...  *Sniff*  I tried.  I 
was weak...!

Rob
