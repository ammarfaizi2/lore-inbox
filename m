Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317785AbSHCU5c>; Sat, 3 Aug 2002 16:57:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317815AbSHCU5c>; Sat, 3 Aug 2002 16:57:32 -0400
Received: from www.jubileegroup.co.uk ([212.22.195.7]:26640 "EHLO
	www2.jubileegroup.co.uk") by vger.kernel.org with ESMTP
	id <S317785AbSHCU5b>; Sat, 3 Aug 2002 16:57:31 -0400
Date: Sat, 3 Aug 2002 22:00:58 +0100 (BST)
From: Ged Haywood <ged@www2.jubileegroup.co.uk>
To: "Mr. James W. Laferriere" <babydr@baby-dragons.com>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.4.19
In-Reply-To: <Pine.LNX.4.44.0208031520560.20471-100000@filesrv1.baby-dragons.com>
Message-ID: <Pine.LNX.4.21.0208032156330.29654-100000@www2.jubileegroup.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

On Sat, 3 Aug 2002, Mr. James W. Laferriere wrote:

> Haven't the tarballs usuaully been archived as 'linux/' instead of
> 'linux-2.4.19/' ?

Absolutely not.  Many systems have a symlink 'linux' to the current
kernel tree, which is a directory e.g. 'linux-2.2.16'.  If the tarball
extracts into the 'linux' directory it would overwrite the (presumed
working) source.  I'm sure that the use of 'linux' was an oversight.
At least I hope it was.


73,
Ged.

