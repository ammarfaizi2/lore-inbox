Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316591AbSFPVfx>; Sun, 16 Jun 2002 17:35:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316594AbSFPVfw>; Sun, 16 Jun 2002 17:35:52 -0400
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:19700 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S316591AbSFPVft>; Sun, 16 Jun 2002 17:35:49 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Sun, 16 Jun 2002 15:33:37 -0600
To: Andries.Brouwer@cwi.nl
Cc: viro@math.psu.edu, linux-kernel@vger.kernel.org
Subject: Re: [CHECKER] 37 stack variables >= 1K in 2.4.17
Message-ID: <20020616213337.GA22427@clusterfs.com>
Mail-Followup-To: Andries.Brouwer@cwi.nl, viro@math.psu.edu,
	linux-kernel@vger.kernel.org
References: <UTC200206162041.g5GKfhn13251.aeb@smtp.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <UTC200206162041.g5GKfhn13251.aeb@smtp.cwi.nl>
User-Agent: Mutt/1.3.28i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 16, 2002  22:41 +0200, Andries.Brouwer@cwi.nl wrote:
> ...what I disliked while doing this was the name prepare_follow_link.
> Too long. A second time I might pick get_link or so.

prepare_link()?

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

