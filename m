Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265982AbTATOoj>; Mon, 20 Jan 2003 09:44:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265936AbTATOoj>; Mon, 20 Jan 2003 09:44:39 -0500
Received: from virgo.cus.cam.ac.uk ([131.111.8.20]:23492 "EHLO
	virgo.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S265998AbTATOoh>; Mon, 20 Jan 2003 09:44:37 -0500
Date: Mon, 20 Jan 2003 14:53:41 +0000 (GMT)
From: Anton Altaparmakov <aia21@cantab.net>
To: Pawel Kot <pkot@linuxnews.pl>
cc: jlnance@unity.ncsu.edu, linux-kernel@vger.kernel.org
Subject: Re: [ANN] ntfsprogs (formerly Linux-NTFS) 1.7.0beta released
In-Reply-To: <Pine.LNX.4.33.0301201549170.16178-100000@urtica.linuxnews.pl>
Message-ID: <Pine.SOL.3.96.1030120145327.17046A-100000@virgo.cus.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Jan 2003, Pawel Kot wrote:
> On Mon, 20 Jan 2003, Anton Altaparmakov wrote:
> > I consider that completely stable although there have been some reports of
> > hangs but I have never seen one and everyone who has filed a bug report
> > wasn't able to reproduce the hang on request so I am not really sure where
> > the hangs come from... It might not even be the ntfs driver per se but a
> > bad interaction between ntfs and some other kernel subsystem like the mm
> > layer or the block layer. But I have only seen three reports of a system
> > freeze so far and Mandrake who ship the new driver I would assume have
> > more users than that and either they are not complaining or they are not
> > having problems. I hope the latter. (-;
> 
> Were the hangs with 2.5.x kernel or with 2.4.x kernel?

2.4.x.

	Anton
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

