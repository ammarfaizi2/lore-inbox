Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315338AbSFIXqE>; Sun, 9 Jun 2002 19:46:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315372AbSFIXqD>; Sun, 9 Jun 2002 19:46:03 -0400
Received: from rwcrmhc51.attbi.com ([204.127.198.38]:39596 "EHLO
	rwcrmhc51.attbi.com") by vger.kernel.org with ESMTP
	id <S315338AbSFIXqC>; Sun, 9 Jun 2002 19:46:02 -0400
Subject: Re: vfat patch for shortcut display as symlinks for 2.4.18
From: Nicholas Miell <nmiell@attbi.com>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: Daniel Phillips <phillips@bonn-fries.net>,
        Jan Pazdziora <adelton@informatics.muni.cz>, christoph@lameter.com,
        linux-kernel@vger.kernel.org, adelton@fi.muni.cz
In-Reply-To: <200206092205.g59M571515016@saturn.cs.uml.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 09 Jun 2002 16:45:57 -0700
Message-Id: <1023666358.1518.44.camel@entropy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-06-09 at 15:05, Albert D. Cahalan wrote:
> Nicholas Miell writes:
> >> [ insane abuse of VFAT for multi-user systems ]
> >
> > You're not serious, right?
> 
> I'm very serious. The ability to install without partitioning
> is important for hesitant new users.
> 
> Why not? The system might feel "unclean" to you, but it's
> great for converting the Windows users. Not many people
> are willing to trash their one-and-only partition, full of
> data, to experiment with a new OS. Regular users don't
> keep backups. Linux is the only UNIX-like OS that could
> do a respectable job of running multi-user on vfat.

The same thing can be (and is) done using initrd+loopback, with a lot
less effort and all of the usual Unix filesystem semantics.

- Nicholas

