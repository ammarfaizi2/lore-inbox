Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317649AbSFLGz5>; Wed, 12 Jun 2002 02:55:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317650AbSFLGz4>; Wed, 12 Jun 2002 02:55:56 -0400
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:51194 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S317649AbSFLGz4>; Wed, 12 Jun 2002 02:55:56 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Wed, 12 Jun 2002 00:54:17 -0600
To: Alan <alan@clueserver.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Status of FAT CVF?
Message-ID: <20020612065417.GE30507@clusterfs.com>
Mail-Followup-To: Alan <alan@clueserver.org>, linux-kernel@vger.kernel.org
In-Reply-To: <1023856708.2934.9.camel@summanulla.clueserver.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 11, 2002  21:38 -0700, Alan wrote:
> What is the status of fat_cvf in 2.4.x?  Is the code abandoned?
> Supported? Working? Not working? Pining for the fnords?
> 
> I have an old drive I am trying to get data off of and mounting the
> compressed partition via loopback does something strange.  The mount
> point shows no files, but "df" shows the correct amount for data used. 
> (The compressed DriveSpace 3.x partition does contain data.)
> 
> Not urgent.  (I can get the data other ways.)  Just wanting to know how
> bad it is before I start wading into the code.

There was a patch posted last week to l-k which basically removed CVF
support from the kernel entirely, because it was totally non-functional.

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

