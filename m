Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319172AbSIJO5K>; Tue, 10 Sep 2002 10:57:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319173AbSIJO5J>; Tue, 10 Sep 2002 10:57:09 -0400
Received: from zeus.kernel.org ([204.152.189.113]:29595 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S319172AbSIJO5J>;
	Tue, 10 Sep 2002 10:57:09 -0400
Date: Tue, 10 Sep 2002 11:09:38 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: Hans Reiser <reiser@namesys.com>
Cc: linux-kernel@vger.kernel.org, <green@namesys.com>
Subject: Re: [BK] ReiserFS changesets for 2.4 (performs writes more than 4k
 at a time)
In-Reply-To: <3D7DF05E.7030903@namesys.com>
Message-ID: <Pine.LNX.4.44.0209101108590.16288-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 10 Sep 2002, Hans Reiser wrote:

>   This patch should only go in if 2.4.20 is 3 weeks or more away,
> otherwise it should wait for the next pre1.
>
> It passes all of our testing, but it is the kind of code that is more
> likely than most to have elusive lurking bugs.  It cannot be tested in
> 2.5 first because 2.5 is too broken at this particular moment.  For the
> lkml readers let me say that it also should not go onto any distros
> without three weeks of testing.;-)

So lets wait for 2.4.21pre for this one.

We already have enough stuff to be tested on 2.4.20-pre for reiserfs.

