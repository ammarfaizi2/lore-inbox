Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264717AbSJ3Pnw>; Wed, 30 Oct 2002 10:43:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264719AbSJ3Pnw>; Wed, 30 Oct 2002 10:43:52 -0500
Received: from blowme.phunnypharm.org ([65.207.35.140]:51205 "EHLO
	blowme.phunnypharm.org") by vger.kernel.org with ESMTP
	id <S264717AbSJ3Pnv>; Wed, 30 Oct 2002 10:43:51 -0500
Date: Wed, 30 Oct 2002 10:50:05 -0500
From: Ben Collins <bcollins@debian.org>
To: Stelian Pop <stelian.pop@fr.alcove.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux1394-devel@lists.sourceforge.net
Subject: Re: [PATCH 2.5.bk] allow sbp2 driver to compile again
Message-ID: <20021030155005.GI1521@phunnypharm.org>
References: <20021030141338.GF17103@tahoe.alcove-fr> <20021030142611.GG1521@phunnypharm.org> <20021030143218.GH17103@tahoe.alcove-fr> <20021030143720.GH1521@phunnypharm.org> <20021030144004.GI17103@tahoe.alcove-fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021030144004.GI17103@tahoe.alcove-fr>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 30, 2002 at 03:40:04PM +0100, Stelian Pop wrote:
> On Wed, Oct 30, 2002 at 09:37:20AM -0500, Ben Collins wrote:
> 
> > > While we are at it, there are a lot of 'bad: scheduling while atomic!'
> > > and 'sleeping function called from illegal context' when loading
> > > the ohci1394/sbp2 drivers (detailed stack available when compiling
> > > with CONFIG_DEBUG_KERNEL)...
> > 
> > Yeah, I've noticed aswell. Problem is I don't have a machine that runs
> > 2.5.x stable enough to do some testing.
> 
> Well, it should just be stable enough to survive a modprobe ohci1394...

I don't have any i386's to test with. I'm doing all my 1394 development
on ultrasparc, and a little on ia64, parisc, and powerpc...you know,
real machines :)

I'll be able to look at this over the weekend.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
Deqo       - http://www.deqo.com/
