Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261758AbRFFLOq>; Wed, 6 Jun 2001 07:14:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261759AbRFFLOg>; Wed, 6 Jun 2001 07:14:36 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:58895 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S261758AbRFFLOT>; Wed, 6 Jun 2001 07:14:19 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Sean Hunter <sean@dev.sportingbet.com>,
        Xavier Bestel <xavier.bestel@free.fr>
Subject: Re: Break 2.4 VM in five easy steps
Date: Wed, 6 Jun 2001 13:16:30 +0200
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3B1D5ADE.7FA50CD0@illusionary.com> <991815578.30689.1.camel@nomade> <20010606095431.C15199@dev.sportingbet.com>
In-Reply-To: <20010606095431.C15199@dev.sportingbet.com>
MIME-Version: 1.0
Message-Id: <0106061316300A.00553@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 06 June 2001 10:54, Sean Hunter wrote:

> > Did you try to put twice as much swap as you have RAM ? (e.g. add a
> > 512M swapfile to your box)
> > This is what Linus recommended for 2.4 (swap = 2 * RAM), saying
> > that anything less won't do any good: 2.4 overallocates swap even
> > if it doesn't use it all. So in your case you just have enough swap
> > to map your RAM, and nothing to really swap your apps.
>
> For large memory boxes, this is ridiculous.  Should I have 8GB of
> swap?

And laptops with big memories and small disks.

--
Daniel
