Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267060AbRGQVTK>; Tue, 17 Jul 2001 17:19:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267123AbRGQVTA>; Tue, 17 Jul 2001 17:19:00 -0400
Received: from mueller.uncooperative.org ([216.254.102.19]:8461 "EHLO
	mueller.datastacks.com") by vger.kernel.org with ESMTP
	id <S267060AbRGQVSq>; Tue, 17 Jul 2001 17:18:46 -0400
Date: Tue, 17 Jul 2001 17:18:43 -0400
From: Crutcher Dunnavant <crutcher@datastacks.com>
To: Charles Samuels <charles@kde.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel Documentation
Message-ID: <20010717171843.C21825@mueller.datastacks.com>
In-Reply-To: <200107172102.OAA19756@altair.dhs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200107172102.OAA19756@altair.dhs.org>; from charles@kde.org on Tue, Jul 17, 2001 at 02:02:05PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

++ 17/07/01 14:02 -0700 - Charles Samuels:
> On 2001-07-17 20:46:24, Ignacio Vazquez-Abrams <ignacio@openservices.net> 
> wrote:
> 
> > This is probably a silly question, but why doesn't your site just use
> > DocBook?
> 
> DocBook is more "bookish" complete with chapters and all.  I've used it 
> before, it's nice, but not for this, in my opinion.  Also, the backend just 
> moves the XML data into a temporary MySQL database for easy searching, and 
> sorting, and something like that, I think, would be much more difficult with 
> docbook.

2 things:

1: there is a project in the kernel to establish API references.
you should not duplicate this work, but should add to it.
Reason: There is no way you can get or stay ahead.

2: the secondary issue of documenting best practices in the
kernel is a different matter altogether. I, myself, have started
a project to do this. I'm sorta scared of letting people know
about it at this point, but I feel it is necessary.

the entry point is:
http://bama.ua.edu/~dunn001/journeyman/

I /am/ looking for help, but it is very early. I am NOT looking
for exposure, so dont even bother looking if you dont want to write
docs; there isnt anything there for you.

-- 
Crutcher        <crutcher@datastacks.com>
GCS d--- s+:>+:- a-- C++++$ UL++++$ L+++$>++++ !E PS+++ PE Y+ PGP+>++++
    R-(+++) !tv(+++) b+(++++) G+ e>++++ h+>++ r* y+>*$
