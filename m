Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265527AbTFMUqt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 16:46:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265528AbTFMUqs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 16:46:48 -0400
Received: from windsormachine.com ([206.48.122.28]:44305 "EHLO
	router.windsormachine.com") by vger.kernel.org with ESMTP
	id S265527AbTFMUqr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 16:46:47 -0400
Date: Fri, 13 Jun 2003 17:00:35 -0400 (EDT)
From: Mike Dresser <mdresser_l@windsormachine.com>
To: <linux-kernel@vger.kernel.org>
Subject: Re: 3ware and two drive hardware raid1
In-Reply-To: <49562.10.10.10.1.1055537200.squirrel@www.greenhydrant.com>
Message-ID: <Pine.LNX.4.33.0306131657250.10271-100000@router.windsormachine.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Jun 2003, David Rees wrote:

> Mike Dresser said:
> > On Fri, 13 Jun 2003, Stephan von Krawczynski wrote:
> >> I can confirm that the 3dm daemon is very handy. Especially the media
> >> scan is highly recommended, as it finds problems on areas where there
> >> is no production data yet. So there always is a good chance for
> >> replacement before actual failure.
> >
> > The tw_cli has a similar function, in that you can maint verify c# u#
>
> Were you using it to confirm the status of your disks?

Yes.

The other Windows PC onsite that I was working on turned out to be
rebooting randomly.  When I investigated, turned out that it's the battery
backup.  Unplug the battery backup, and a few seconds later(maybe 10), the
computer would reboot.

Based on that damaged batterybackup, and that it just started doing it
yesterday morning, I'd say we had a lightning hit on the two buildings,
especially since we had a storm that night.

Both drives in the backup server were damaged, one was completely dead,
the other was barely running.  I was able to copy off all but about 10
files, of which all of it was easily replaceable anyways.

The drives were functional before the lightning hit.

Mike

