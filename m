Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316185AbSFJCV3>; Sun, 9 Jun 2002 22:21:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316187AbSFJCV2>; Sun, 9 Jun 2002 22:21:28 -0400
Received: from melchi.fuller.edu ([65.118.138.13]:30982 "EHLO
	melchi.fuller.edu") by vger.kernel.org with ESMTP
	id <S316185AbSFJCV2>; Sun, 9 Jun 2002 22:21:28 -0400
Date: Sun, 9 Jun 2002 19:20:38 -0700 (PDT)
From: <christoph@lameter.com>
X-X-Sender: <christoph@melchi.fuller.edu>
To: Nicholas Miell <nmiell@attbi.com>
cc: "Albert D. Cahalan" <acahalan@cs.uml.edu>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Jan Pazdziora <adelton@informatics.muni.cz>,
        <linux-kernel@vger.kernel.org>, <adelton@fi.muni.cz>
Subject: Re: vfat patch for shortcut display as symlinks for 2.4.18
In-Reply-To: <1023674799.1518.54.camel@entropy>
Message-ID: <Pine.LNX.4.33.0206091920120.20297-100000@melchi.fuller.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9 Jun 2002, Nicholas Miell wrote:

> On Sun, 2002-06-09 at 18:58, Albert D. Cahalan wrote:
> > > That's not any different than having seperate VFAT and ext2
> > > partitions in a standard dual-boot situation.
> >
> > Sure. That obviously sucks; Linux can do better.
> > It's important to make a transition to Linux as
> > painless as possible. Nobody considering an OS
> > change likes the feeling that their data files
> > are trapped on one side or the other.
>
> Huh? Windows can access files on VFAT and Linux can access files on
> VFAT. How are they "trapped"?

Because you are forbidding them to have symlink support.

