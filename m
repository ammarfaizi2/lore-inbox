Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261703AbSJJRAL>; Thu, 10 Oct 2002 13:00:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261705AbSJJRAK>; Thu, 10 Oct 2002 13:00:10 -0400
Received: from h68-147-110-38.cg.shawcable.net ([68.147.110.38]:45307 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S261703AbSJJRAK>; Thu, 10 Oct 2002 13:00:10 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Thu, 10 Oct 2002 11:03:17 -0600
To: Daniel Phillips <phillips@arcor.de>
Cc: Andrew_Purtell@NAI.com, tytso@mit.edu, linux-kernel@vger.kernel.org
Subject: Re: two problems using EXT3 htrees
Message-ID: <20021010170317.GI3045@clusterfs.com>
Mail-Followup-To: Daniel Phillips <phillips@arcor.de>,
	Andrew_Purtell@NAI.com, tytso@mit.edu, linux-kernel@vger.kernel.org
References: <1D4F16D4D695D21186A300A0C9DCF9838F611F@LOS-83-207.nai.com> <E17zd3i-0008A8-00@starship>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E17zd3i-0008A8-00@starship>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 10, 2002  15:08 +0200, Daniel Phillips wrote:
> On Wednesday 09 October 2002 20:29, Andrew_Purtell@NAI.com wrote:
> > I recently patched my 2.4.19 kernel with EXT3 dir_index support and tried
> > it out on my 80GB EXT3 data partition...
> 
> Could you please provide a pointer to the patch you used?

A number of people have been getting this same bug under high load.  I
believe they are using the patches from Ted, and/or BK extfs.bkbits.net.

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

