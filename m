Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268156AbTCFTkp>; Thu, 6 Mar 2003 14:40:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268201AbTCFTko>; Thu, 6 Mar 2003 14:40:44 -0500
Received: from divine.city.tvnet.hu ([195.38.100.154]:52074 "EHLO
	divine.city.tvnet.hu") by vger.kernel.org with ESMTP
	id <S268156AbTCFTko>; Thu, 6 Mar 2003 14:40:44 -0500
Date: Thu, 6 Mar 2003 20:41:46 +0100 (MET)
From: Szakacsits Szabolcs <szaka@sienet.hu>
To: "Randy.Dunlap" <rddunlap@osdl.org>
cc: <aia21@cantab.net>, <linux-kernel@vger.kernel.org>,
       <linux-ntfs-dev@lists.sourceforge.net>
Subject: Re: [Linux-NTFS-Dev] ntfs OOPS (2.5.63)
In-Reply-To: <20030306113942.6f9bbbf5.rddunlap@osdl.org>
Message-ID: <Pine.LNX.4.30.0303062035390.31029-100000@divine.city.tvnet.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 6 Mar 2003, Randy.Dunlap wrote:
> On Thu, 6 Mar 2003 15:34:52 +0100 (MET) Szakacsits Szabolcs <szaka@sienet.hu> wrote:

> | Anyway, considering how bogus the oops was and Randy already had two
> | oops'es before this NTFS one, I think the NTFS driver was a sufferer
> | of other trouble(s) than the originator. So unless one can reproduce
> | something close to this one (or Randy sends his first [two] oops), I
> | would just trash
> |
> | 	http://bugme.osdl.org/show_bug.cgi?id=432
>
> I must have missed something here.  What other 2 oopses are you referring to?

Quoting from your report:

==> Mar  1 13:35:44 midway kernel: Oops: 0002

This means oops counter is 2. So there were two oopses before with
counter value 0 and 1.

> As for closing bug reports because they are not reproducible...

No. Not because it's not reproducible however because it's untrustable
and bogus. Unless as I mentioned before ... please see above. Thanks!

	Szaka

