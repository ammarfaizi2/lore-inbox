Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314238AbSDRFuF>; Thu, 18 Apr 2002 01:50:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314239AbSDRFuE>; Thu, 18 Apr 2002 01:50:04 -0400
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:13299 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S314238AbSDRFuE>; Thu, 18 Apr 2002 01:50:04 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Wed, 17 Apr 2002 23:48:35 -0600
To: Mel <mel@csn.ul.ie>
Cc: linux-kernel@vger.kernel.org
Subject: Re: page_alloc.c comments patch
Message-ID: <20020418054835.GA26101@turbolinux.com>
Mail-Followup-To: Mel <mel@csn.ul.ie>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0204180306050.4760-100000@skynet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 18, 2002  03:26 +0100, Mel wrote:
> This patch is a first cut effort at commenting how the buddy algorithm
> works for allocating and freeing blocks of pages. No code is changed so
> the impact is minimal to put it mildly

Two minor things I saw:
1) The function documentation comments need to start with "/**" - see
   linux/Documentation/kernel-doc-nano-HOWTO.txt.
2) Please keep comments <= 80 columns.

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

