Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277580AbRJHWkG>; Mon, 8 Oct 2001 18:40:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277138AbRJHWjq>; Mon, 8 Oct 2001 18:39:46 -0400
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:60129 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S277578AbRJHWjf>; Mon, 8 Oct 2001 18:39:35 -0400
Date: Mon, 8 Oct 2001 18:39:56 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: kernel@ddx.a2000.nu
Cc: Joel Jaeggli <joelja@darkwing.uoregon.edu>,
        Thomas Duffy <Thomas.Duffy.99@alumni.brown.edu>,
        "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org,
        sparclinux@vger.kernel.org
Subject: Re: sun + gigabit nic
Message-ID: <20011008183955.B12711@redhat.com>
In-Reply-To: <Pine.LNX.4.33.0110081518370.17654-100000@twin.uoregon.edu> <Pine.LNX.4.40.0110090031000.28619-100000@ddx.a2000.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.40.0110090031000.28619-100000@ddx.a2000.nu>; from kernel@ddx.a2000.nu on Tue, Oct 09, 2001 at 12:32:52AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 09, 2001 at 12:32:52AM +0200, kernel@ddx.a2000.nu wrote:
> On Mon, 8 Oct 2001, Joel Jaeggli wrote:
> >
> > the 620t is the netgear gig-card based on the acenic, it' optical, sx or
> > lx.
> >
> hmms think you mean also copper ?
> i found the ga620t card on shopper.com, for about $300, while the ga622t
> is
> about $100, no change it will be supported ? (don't like to pay 3* more
> when support is comming)

The GA622T is driven by ns83820.c, which I'm still trying to get enough 
information to track down why it isn't working on sparc64.  I have a hunch, 
but have yet to find the time to investigate.

		-ben
