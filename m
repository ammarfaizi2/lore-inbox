Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280824AbRKGUVA>; Wed, 7 Nov 2001 15:21:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280952AbRKGUUu>; Wed, 7 Nov 2001 15:20:50 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:37627 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S280824AbRKGUUh>;
	Wed, 7 Nov 2001 15:20:37 -0500
Date: Wed, 7 Nov 2001 13:19:30 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: "Zvi Har'El" <rl@math.technion.ac.il>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Roy Sigurd Karlsbakk <roy@karlsbakk.net>, linux-kernel@vger.kernel.org,
        nyh@math.technion.ac.il
Subject: Re: ext3 vs resiserfs vs xfs
Message-ID: <20011107131930.H5922@lynx.no>
Mail-Followup-To: Zvi Har'El <rl@math.technion.ac.il>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Roy Sigurd Karlsbakk <roy@karlsbakk.net>,
	linux-kernel@vger.kernel.org, nyh@math.technion.ac.il
In-Reply-To: <E161UYR-0004S5-00@the-village.bc.nu> <Pine.GSO.4.33.0111071726260.2977-100000@leeor.math.technion.ac.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <Pine.GSO.4.33.0111071726260.2977-100000@leeor.math.technion.ac.il>; from rl@math.technion.ac.il on Wed, Nov 07, 2001 at 05:28:40PM +0200
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 07, 2001  17:28 +0200, Zvi Har'El wrote:
> I get this countdown, but after 5 seconds fsck starts anyway, without me
> hitting Y! Should I hit N, or should I change some config somewhere? Now each
> time my battery runs out, I need fsck!

Are you SURE you are using ext3?  Check /proc/mounts to be sure.  What it
says in /etc/fstab is irrelevant for the root filesystem.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

