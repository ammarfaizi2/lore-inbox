Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287874AbSA3BXy>; Tue, 29 Jan 2002 20:23:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287868AbSA3BXo>; Tue, 29 Jan 2002 20:23:44 -0500
Received: from tomts19-srv.bellnexxia.net ([209.226.175.73]:40934 "EHLO
	tomts19-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S287858AbSA3BXg>; Tue, 29 Jan 2002 20:23:36 -0500
Content-Type: text/plain; charset=US-ASCII
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: Linus Torvalds <torvalds@transmeta.com>
Subject: Re: A modest proposal -- We need a patch penguin
Date: Tue, 29 Jan 2002 20:23:08 -0500
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020130012308.B37AA6FB3@oscar.casa.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
 
> On Tue, 29 Jan 2002, Rob Landley wrote:
>> > >
>> > > Then why not give the subsystem maintainers patch permissions on your
>> > > tree. Sort of like committers.  The problem people have is that
>> > > you're dropping patches from those ten-twenty people you trust.
>> >
>> > No. Ask them, and they will (I bet) pretty uniformly tell you that I'm
>> > _not_ dropping their patches (although I'm sometimes critical of them,
>> > and will tell them that they do not get applied).
>>
>> Andre Hedrick, Eric Raymond, Rik van Riel, Michael Elizabeth Chastain,
>> Axel Boldt...
> 
> NONE of those are in the ten-twenty people group.
> 
> How many people do you think fits in a small group? Hint. It sure isn't
> all 300 on the maintainers list.
> 
>> Ah.  So being listed in the maintainers list doesn't mean someone is
>> actually a maintainer it makes sense to forward patches to?
> 
> Sure it does.
> 
> It just doesn't mean that they should send stuff to _me_.

This is the salient point.  I have been reading lkml for about two years 
and it was not an obivous one...  

> Did you not understand my point about scalability?  I can work with a
> limited number of people, and those people can work with _their_ limited
> number of people etc etc.

Why not arange the MAINTAINERS file so everyone knows the path you would
like patches to follow?  If everyone understands they should first try
lkml or the MAINTAINER and, once the MAINTAINER and/or lkml agree, the patch 
should be sent (by the MAINTAINER if he/she was involved) to a trustee who 
vets it again and sends it on to you.

Why not formalize the list of 'trustees' in the MAINTAINER files?  

IMO people will happily work with your procedures, but they _do_ have to 
understand them - not always an easy task.
 
<grin>

Ed Tomlinson
