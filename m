Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290228AbSBFHvp>; Wed, 6 Feb 2002 02:51:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290223AbSBFHvd>; Wed, 6 Feb 2002 02:51:33 -0500
Received: from smtp1.ndsu.NoDak.edu ([134.129.111.146]:52750 "EHLO
	smtp1.ndsu.nodak.edu") by vger.kernel.org with ESMTP
	id <S290228AbSBFHvT>; Wed, 6 Feb 2002 02:51:19 -0500
Subject: Re: linux-2.5.4-pre1 - bitkeeper testing
From: Reid Hekman <reid.hekman@ndsu.nodak.edu>
To: Andreas Dilger <adilger@turbolabs.com>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20020205235000.J2928@lynx.turbolabs.com>
In-Reply-To: <Pine.LNX.4.31.0202051928330.2375-100000@cesium.transmeta.com> 
	<20020205235000.J2928@lynx.turbolabs.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 06 Feb 2002 01:50:34 -0600
Message-Id: <1012981874.6918.10.camel@zeus>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-02-06 at 00:50, Andreas Dilger wrote:
> On Feb 05, 2002  19:37 -0800, Linus Torvalds wrote:
> > For a first example, the ChangeLog file for 2.5.4-pre1 is rather more
> > detailed than usual (in fact, right now it is _too_ detailed, and I
> > haven't written the scripts to "terse it down" for postings to
> > linux-kernel, for example).
> 
> Well, I for one would rather have these verbose messages than very terse
> messages (or none at all).  

I second that. Maybe however we can have it both ways -- I have no
experience with bk, but can't this same info be made available elsewhere
like a public web interface or some such thing?

> Actually, having the full email explanation
> helps other readers just as much as it helps you, and having the subject
> lines helps go back to the specific message/thread in l-k (if the patch
> was also posted there).

If the Changelogs stay verbose on lkml, possibly the list itself would
be more "searchable" -- people hunting specific bugs and kernel versions
would hit the release announcements as kind of an index into the
discussion.

Regards,
Reid

