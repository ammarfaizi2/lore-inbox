Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316189AbSETS0p>; Mon, 20 May 2002 14:26:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316194AbSETS0o>; Mon, 20 May 2002 14:26:44 -0400
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:60405 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S316189AbSETS0n>; Mon, 20 May 2002 14:26:43 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Mon, 20 May 2002 12:24:57 -0600
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Mounting 'foreign' file-systems
Message-ID: <20020520182457.GA7784@turbolinux.com>
Mail-Followup-To: "Richard B. Johnson" <root@chaos.analogic.com>,
	Linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.3.95.1020520111351.169A-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On May 20, 2002  11:22 -0400, Richard B. Johnson wrote:
> On Linux 2.4.18, I can no longer mount CDROMs that were created
> using ext2 as the file-system (yes I know this is not specified).
> I used to use these CDROMs as part of a "rescue" package.
> 
> Now, these can still be mounted through the loop device as is
> shown below....

Probably a filesystem != CDROM blocksize issue.

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

