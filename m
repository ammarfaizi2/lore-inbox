Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288810AbSAXSSZ>; Thu, 24 Jan 2002 13:18:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288830AbSAXSSP>; Thu, 24 Jan 2002 13:18:15 -0500
Received: from dsl-213-023-043-085.arcor-ip.net ([213.23.43.85]:21923 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S288800AbSAXSSA>;
	Thu, 24 Jan 2002 13:18:00 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Giacomo Catenazzi <cate@dplanet.ch>
Subject: Re: [kbuild-devel] Re: CML2-2.1.3 is available
Date: Wed, 23 Jan 2002 22:45:52 +0100
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
In-Reply-To: <20020115145324.A5772@thyrsus.com> <3C4C4A60.7030700@dplanet.ch> 
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16ToWU-0002lz-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 22, 2002 12:11 am, Daniel Phillips wrote:
> On January 21, 2002 06:05 pm, Giacomo Catenazzi wrote:
> > Daniel Phillips wrote:
> > > 
> > > I detect a slight lack of symmetry here, shouldn't it be "make
> > > autoconfig"? Pardon me if this has been beaten to^W^W discussed above.
> > 
> > Yes. It should be "make autoconfig", for symmterty reasons :-)
> > I called the files and the project autoconfigure, because
> > 'autoconfig' is already an utility made by GNU. (not related
> > to kernel)
> 
> This is kernel autoconfig, different namespace, same idea.  I don't think
> you have a problem.  Besides, last time I checked, autoconfig wasn't 
> copyrighted.

Oh wait, the 'real autoconf' is called autoconf, not autoconfig (duh) so 
there is no reason at all to avoid 'make autoconfig'.

--
Daniel

