Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315222AbSFIVaw>; Sun, 9 Jun 2002 17:30:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315232AbSFIVav>; Sun, 9 Jun 2002 17:30:51 -0400
Received: from rwcrmhc51.attbi.com ([204.127.198.38]:9646 "EHLO
	rwcrmhc51.attbi.com") by vger.kernel.org with ESMTP
	id <S315222AbSFIVau>; Sun, 9 Jun 2002 17:30:50 -0400
Subject: Re: vfat patch for shortcut display as symlinks for 2.4.18
From: Nicholas Miell <nmiell@attbi.com>
To: Thunder from the hill <thunder@ngforever.de>
Cc: Diego Calleja <diegocg@teleline.es>, phillips@bonn-fries.net,
        adelton@informatics.muni.cz, christoph@lameter.com,
        linux-kernel@vger.kernel.org, adelton@fi.muni.cz
In-Reply-To: <Pine.LNX.4.44.0206091438280.8715-100000@hawkeye.luckynet.adm>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 09 Jun 2002 14:30:45 -0700
Message-Id: <1023658246.1659.4.camel@entropy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-06-09 at 13:40, Thunder from the hill wrote:
> Hi,
> 
> On Sun, 9 Jun 2002, Diego Calleja wrote:
> > I agree. M$ did .lnk _files_, but really, there's not symlinks in vfat
> > world. Even msdos doesn't recognize them. I don't remember if it's the
> > same in NTFS, W2000 & XP are so good that I can't work with them in 32MB
> > RAM...
> 
> Some time ago I found a document proposing a different API for Windows 
> 2002 which was supposed to include symlinks into ntfs, so I don't think 
> it was there.
> 

NTFS is a real filesystem, unlike VFAT. It has native support for hard
links, and, IIRC, the version that ships with Windows XP can do
something similar to symbolic links.

