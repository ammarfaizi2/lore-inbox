Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314685AbSD3Sqf>; Tue, 30 Apr 2002 14:46:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314743AbSD3Sqe>; Tue, 30 Apr 2002 14:46:34 -0400
Received: from 189-VALL-X7.libre.retevision.es ([62.83.213.189]:18957 "EHLO
	ragnar-hojland.com") by vger.kernel.org with ESMTP
	id <S314685AbSD3Sqe>; Tue, 30 Apr 2002 14:46:34 -0400
Date: Tue, 30 Apr 2002 20:46:15 +0200
From: Ragnar Hojland Espinosa <ragnar@jazzfree.com>
To: linux-kernel@vger.kernel.org
Cc: Roy Sigurd Karlsbakk <roy@karlsbakk.net>,
        Zwane Mwaikambo <zwane@linux.realnet.co.sz>
Subject: Re: IDE hotplug support?
Message-ID: <20020430204615.A8453@ragnar-hojland.com>
In-Reply-To: <Pine.LNX.4.44.0204301746020.2301-100000@mustard.heime.net> <Pine.LNX.4.44.0204301801570.25786-100000@netfinity.realnet.co.sz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
Organization: Mediocrity Naysayers Ltd
X-Homepage: http://lightside.eresmas.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 30, 2002 at 06:22:06PM +0200, Zwane Mwaikambo wrote:
> On Tue, 30 Apr 2002, Roy Sigurd Karlsbakk wrote:
> 
> > I came across a nice case from procase, supporting 16 IDE drives in 
> > (so-called?) hotplug frames. Problem is... How will linux trat this?
> 
> Wasn't this flogged, subjected to Britney Spears, humiliated in front of 
> friends and family and dragged through the streets with nigh but its 
> birthday suit revealing the scurvy it contracted from spending 3 
> years aboard a naval vessel recently?

Actually no.  The conclusion of that thread was something like common OTS
IDE components aren't hot swappable, because even if we ignore the bus shock
problem and the controller supports proper power down, the hard disk
probabily won't.

Considering Roy is asking about specific hardware its not of much relevance
overall.
-- 
____/|  Ragnar Højland      Freedom - Linux - OpenGL | CCNA - Brainbench MVP
\ o.O|  PGP94C4B2F0D27DE025BE2302C104B78C56 B72F0822 |  for Unix Programming
 =(_)=  "Thou shalt not follow the NULL pointer for  |  (www.brainbench.com)
   U     chaos and madness await thee at its end."      [38 pend. Mar 10]
