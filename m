Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266927AbSLPRVZ>; Mon, 16 Dec 2002 12:21:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266932AbSLPRVS>; Mon, 16 Dec 2002 12:21:18 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:25956 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S266933AbSLPRUp>; Mon, 16 Dec 2002 12:20:45 -0500
Date: Mon, 16 Dec 2002 17:28:38 +0000
From: Arjan van de Ven <arjanv@redhat.com>
To: Ben Collins <bcollins@debian.org>
Cc: Larry McVoy <lm@work.bitmover.com>, Arjan van de Ven <arjanv@redhat.com>,
       Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
       Larry McVoy <lm@bitmover.com>
Subject: Re: Notification hooks
Message-ID: <20021216172838.B976@devserv.devel.redhat.com>
References: <20021216171218.GV504@hopper.phunnypharm.org> <1040059138.1438.1.camel@laptop.fenrus.com> <20021216092129.D432@work.bitmover.com> <20021216172722.GX504@hopper.phunnypharm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021216172722.GX504@hopper.phunnypharm.org>; from bcollins@debian.org on Mon, Dec 16, 2002 at 12:27:22PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 16, 2002 at 12:27:22PM -0500, Ben Collins wrote:
> > bk help triggers.
> 
> Well, if it affects more than just the files I am interested in, I only
> want the diff for those files, but the changeset log and files-affected
> for the whole changeset.
> 
> If I want the full diff I can go to bkbits or the archive of the commit
> list.

well grepdiff and filterdiff can do that I bet... 
filterdiff takes a wildcard and only lets patches through that touch files
that match this wildcard...
