Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261348AbTCODnq>; Fri, 14 Mar 2003 22:43:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261349AbTCODnq>; Fri, 14 Mar 2003 22:43:46 -0500
Received: from h68-147-110-38.cg.shawcable.net ([68.147.110.38]:32242 "EHLO
	schatzie.adilger.int") by vger.kernel.org with ESMTP
	id <S261348AbTCODnq>; Fri, 14 Mar 2003 22:43:46 -0500
Date: Fri, 14 Mar 2003 20:54:14 -0700
From: Andreas Dilger <adilger@clusterfs.com>
To: war@lucidpixels.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Broadcom BCM5702 Major Problems
Message-ID: <20030314205414.U12806@schatzie.adilger.int>
Mail-Followup-To: war@lucidpixels.com, linux-kernel@vger.kernel.org
References: <20030315023244.3013.qmail@lucidpixels.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030315023244.3013.qmail@lucidpixels.com>; from war@lucidpixels.com on Sat, Mar 15, 2003 at 02:32:44AM -0000
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 15, 2003  02:32 -0000, war@lucidpixels.com wrote:
> When compiled in statically it does not work.
> Loading the module after the entire system loads, then ifconfigging works ok.
> Hm, maybe PCI sharing must be turned off, I read this from somewhere on google?
> I am also running latest stable kernel 2.4.21-pre5-7.

We are having similar problems with the Broadcom driver, and would be
very interested in finding a solution.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

