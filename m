Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265886AbTATOjJ>; Mon, 20 Jan 2003 09:39:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265894AbTATOjJ>; Mon, 20 Jan 2003 09:39:09 -0500
Received: from urtica.linuxnews.pl ([217.67.200.130]:31763 "EHLO
	urtica.linuxnews.pl") by vger.kernel.org with ESMTP
	id <S265886AbTATOjI>; Mon, 20 Jan 2003 09:39:08 -0500
Date: Mon, 20 Jan 2003 15:48:04 +0100 (CET)
From: Pawel Kot <pkot@linuxnews.pl>
To: <jlnance@unity.ncsu.edu>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [ANN] ntfsprogs (formerly Linux-NTFS) 1.7.0beta released
In-Reply-To: <20030120133938.GA2842@ncsu.edu>
Message-ID: <Pine.LNX.4.33.0301201547380.16178-100000@urtica.linuxnews.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Jan 2003 jlnance@unity.ncsu.edu wrote:

> On Sun, Jan 19, 2003 at 04:05:50PM +0100, Pawel Kot wrote:
>
> > There exists a new ntfs driver called NTFS-TNG, which is present already
> > in 2.5.x kernel series and it has its backport to the 2.4.x kernel series
> > (you'll find it at http://linux-ntfs.sf.net/).
> >
> > This driver has no write support yet, but it allows you to overwrite the
> > files, without changing their attributes and size (ie. mmap() the file,
> > change the contents, write() the file). And the overwrite is considered
> > safe.
>
> Is this stable enough to allow you to put an ext2 image on an NTFS
> partition and then mount that image as a r/w loopback mount from
> Linux?

Yes.

pkot
-- 
mailto:pkot@linuxnews.pl :: mailto:pkot@slackware.pl
http://kt.linuxnews.pl/ :: Kernel Traffic po polsku

