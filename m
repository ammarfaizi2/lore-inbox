Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317434AbSIJUCC>; Tue, 10 Sep 2002 16:02:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317622AbSIJUCC>; Tue, 10 Sep 2002 16:02:02 -0400
Received: from otter.mbay.net ([206.55.237.2]:13842 "EHLO otter.mbay.net")
	by vger.kernel.org with ESMTP id <S317434AbSIJUCB> convert rfc822-to-8bit;
	Tue, 10 Sep 2002 16:02:01 -0400
From: John Alvord <jalvo@mbay.net>
To: Shawn <core@enodev.com>
Cc: Mike Galbraith <efault@gmx.de>, Shawn <core@enodev.com>,
       Andi Kleen <ak@suse.de>,
       Thunder from the hill <thunder@lightweight.ods.org>,
       linux-kernel@vger.kernel.org
Subject: Re: XFS?
Date: Tue, 10 Sep 2002 13:06:27 -0700
Message-ID: <92ksnuc403ubdr07dqvnor1mf9lr18srij@4ax.com>
References: <p73wupuq34l.fsf@oldwotan.suse.de> <20020909193820.GA2007@lnuxlab.ath.cx.suse.lists.linux.kernel> <Pine.LNX.4.44.0209091457590.3793-100000@hawkeye.luckynet.adm.suse.lists.linux.kernel> <p73wupuq34l.fsf@oldwotan.suse.de> <20020909162050.B4781@q.mn.rr.com> <5.1.0.14.2.20020910190828.00b27258@pop.gmx.net> <20020910142347.A5000@q.mn.rr.com>
In-Reply-To: <20020910142347.A5000@q.mn.rr.com>
X-Mailer: Forte Agent 1.92/32.570
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Sep 2002 14:23:47 -0500, Shawn <core@enodev.com> wrote:

>I'm not sure what this is intended to communicate.
>
>The question was specifically regarding filesystem support, so I'll
>assume you meant to point out that XFS does not always work like it
>should.
>
>Then, am I incorrect that since almost all of XFS that's left to merge
>is XFS code and not changes to the kernel at large?
>
>If this is correct, could I then make the assumption that merging XFS
>would be minimally impactful for those kernel user who do not enable it?
>
>Linus incorporated reiserfs long before it "always functioned as it is
>supposed to", so I find myself wondering where your point was.

If memory serves, Linus incorporated reiserfs after several major
distributors started including it. Linus seems to pay a lot of
attention to distributions in areas where he isn't so much interested.

So does Redhat/Suse/??? ship XFS yet?

john

