Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262248AbSJQWUY>; Thu, 17 Oct 2002 18:20:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262266AbSJQWUY>; Thu, 17 Oct 2002 18:20:24 -0400
Received: from h68-147-110-38.cg.shawcable.net ([68.147.110.38]:48366 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S262248AbSJQWUX>; Thu, 17 Oct 2002 18:20:23 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Thu, 17 Oct 2002 16:22:55 -0600
To: Russell Coker <russell@coker.com.au>
Cc: Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org,
       linux-security-module@wirex.com
Subject: Re: [PATCH] remove sys_security
Message-ID: <20021017222255.GE14989@clusterfs.com>
Mail-Followup-To: Russell Coker <russell@coker.com.au>,
	Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org,
	linux-security-module@wirex.com
References: <Pine.GSO.4.21.0210171742050.18575-100000@weyl.math.psu.edu> <200210180014.16512.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200210180014.16512.russell@coker.com.au>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 18, 2002  00:14 +0200, Russell Coker wrote:
> When are extended attributes going to be in Ext2/3?  This issue could be 
> solved through them, but not in any other way AFAIK.

Ted is actively trying to merge them in 2.5.

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

