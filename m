Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288984AbSAITzY>; Wed, 9 Jan 2002 14:55:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288991AbSAITzE>; Wed, 9 Jan 2002 14:55:04 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:39933 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S288996AbSAITyl>;
	Wed, 9 Jan 2002 14:54:41 -0500
Date: Wed, 9 Jan 2002 12:54:11 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Pozsar Balazs <pozsy@sch.bme.hu>
Cc: jgarzik@mandrakesoft.com, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 8139too: too early dev_kfree_skb
Message-ID: <20020109125411.R769@lynx.adilger.int>
Mail-Followup-To: Pozsar Balazs <pozsy@sch.bme.hu>,
	jgarzik@mandrakesoft.com,
	linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.GSO.4.30.0201092029570.14274-100000@balu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.GSO.4.30.0201092029570.14274-100000@balu>; from pozsy@sch.bme.hu on Wed, Jan 09, 2002 at 08:35:24PM +0100
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 09, 2002  20:35 +0100, Pozsar Balazs wrote:
> This patch was originally sent to lkml on nov 30, 2001, from
> <kumon@flab.fujitsu.co.jp>, but it is not in 2.4.18-pre2.
> 
> Was it just overlooked, or is it unneccessary?

I seem to recall that it was solved differently.  Please read the whole
thread.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

