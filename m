Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265689AbSKODoM>; Thu, 14 Nov 2002 22:44:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265700AbSKODoM>; Thu, 14 Nov 2002 22:44:12 -0500
Received: from packet.digeo.com ([12.110.80.53]:39917 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S265689AbSKODoL>;
	Thu, 14 Nov 2002 22:44:11 -0500
Message-ID: <3DD46F21.4012FCB0@digeo.com>
Date: Thu, 14 Nov 2002 19:50:57 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Thomas Molina <tmolina@cox.net>
CC: "Martin J. Bligh" <mbligh@aracnet.com>,
       "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Bugzilla bug tracking database for 2.5 now available.
References: <3DD4614B.A57EE8C5@digeo.com> <Pine.LNX.4.44.0211142132500.2229-100000@dad.molina>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Nov 2002 03:50:59.0792 (UTC) FILETIME=[35D56D00:01C28C5A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Molina wrote:
> 
> ...
> Has my 2.5 Problem Report Status postings been useful?

I think it's at the stage where it needs a "nag" factor.  Those little
reminder emails from bugzilla are really irritating.

>  If so, when I
> discussed this with Martin one of the roles we agreed I would play was
> taking bug reports from the list and adding them to bugzilla.  I'll also
> be a "filter" for some of the issues discussed in this thread, sort of a
> janitor if you will.

Sounds very useful.
 
> My question is how should compile failures figure into the bug database?
> Most of the compile failures are typos or thinkos that get quickly fixed.
> Should they get tracked, or dismissed quickly unless they linger on.  I
> didn't track simple compile failures in my list.

I'd say don't include them.  It's not as if we're likely to forget
about them.
