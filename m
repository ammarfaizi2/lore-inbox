Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266924AbSLPRgm>; Mon, 16 Dec 2002 12:36:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266918AbSLPRgm>; Mon, 16 Dec 2002 12:36:42 -0500
Received: from blowme.phunnypharm.org ([65.207.35.140]:64007 "EHLO
	blowme.phunnypharm.org") by vger.kernel.org with ESMTP
	id <S266898AbSLPRgi>; Mon, 16 Dec 2002 12:36:38 -0500
Date: Mon, 16 Dec 2002 12:44:26 -0500
From: Ben Collins <bcollins@debian.org>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Larry McVoy <lm@work.bitmover.com>,
       Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
       Larry McVoy <lm@bitmover.com>
Subject: Re: Notification hooks
Message-ID: <20021216174426.GB504@hopper.phunnypharm.org>
References: <20021216171218.GV504@hopper.phunnypharm.org> <1040059138.1438.1.camel@laptop.fenrus.com> <20021216092129.D432@work.bitmover.com> <20021216172722.GX504@hopper.phunnypharm.org> <20021216172838.B976@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021216172838.B976@devserv.devel.redhat.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 16, 2002 at 05:28:38PM +0000, Arjan van de Ven wrote:
> On Mon, Dec 16, 2002 at 12:27:22PM -0500, Ben Collins wrote:
> > > bk help triggers.
> > 
> > Well, if it affects more than just the files I am interested in, I only
> > want the diff for those files, but the changeset log and files-affected
> > for the whole changeset.
> > 
> > If I want the full diff I can go to bkbits or the archive of the commit
> > list.
> 
> well grepdiff and filterdiff can do that I bet... 
> filterdiff takes a wildcard and only lets patches through that touch files
> that match this wildcard...

For all the people that suggested subscribing to the commit list, guess
what, I am.

Problem is that my changeset isn't even listed there. Not a very
dependable way to get that info.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
Deqo       - http://www.deqo.com/
