Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317440AbSFMEAc>; Thu, 13 Jun 2002 00:00:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317441AbSFMEAb>; Thu, 13 Jun 2002 00:00:31 -0400
Received: from louise.pinerecords.com ([212.71.160.16]:56581 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S317440AbSFMEAb>; Thu, 13 Jun 2002 00:00:31 -0400
Date: Thu, 13 Jun 2002 06:00:29 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: Francois Gouget <fgouget@free.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: vfat patch for shortcut display as symlinks for 2.4.18
Message-ID: <20020613040029.GA18894@louise.pinerecords.com>
In-Reply-To: <Pine.LNX.4.43.0206110712290.7449-100000@amboise.dolphin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-OS: GNU/Linux 2.4.19-pre10/sparc SMP
X-Uptime: 8 days, 19:15
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>    - for VFAT one could use the UMSDOS filesystem to do the same thing,
>      and get many other features at the same time (at least while in
>      Linux)

AFAIK, umsdos doesn't work on top of fat32, which makes it practically
unusable in 2002.

T.
