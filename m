Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267505AbTBDWko>; Tue, 4 Feb 2003 17:40:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267506AbTBDWko>; Tue, 4 Feb 2003 17:40:44 -0500
Received: from tomts19.bellnexxia.net ([209.226.175.73]:28822 "EHLO
	tomts19-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S267505AbTBDWkn>; Tue, 4 Feb 2003 17:40:43 -0500
Date: Tue, 4 Feb 2003 17:48:44 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@dell
To: "Randy.Dunlap" <rddunlap@osdl.org>
cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: cleanup of filesystems menu
In-Reply-To: <Pine.LNX.4.33L2.0302041302420.6174-100000@dragon.pdx.osdl.net>
Message-ID: <Pine.LNX.4.44.0302041746230.17535-100000@dell>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Feb 2003, Randy.Dunlap wrote:

> Here are my comments on the filesystem menu:
> 
> That "FS_POSIX_ACL" line is very odd.
> What can be done about/with it?

beats me.  i don't invent 'em, i just organize 'em.
 
> Quota and Automounter:  are they filesystems?
> I know, you didn't change that.
> Anyway, they are more like FS options or tools.

again, i'm open to suggestions.  since this was just
a first attempt, i only moved stuff around within the
same menu for now.  i'm not sure where else these would
go.
 
> I would put the list under "Miscellaneous filesystems"
> in alphabetical order.

easy enough.

 
> Did you modify "Network File Systems" or "Partition Types"?

nope.

> Anyway, they are sort of in historical order and I would
> put them in alpha order too unless there's some
> compelling reason not to do that.

also easy.

rday

