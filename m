Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318122AbSIIR3m>; Mon, 9 Sep 2002 13:29:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318139AbSIIR3l>; Mon, 9 Sep 2002 13:29:41 -0400
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:50928 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S318122AbSIIR3h>; Mon, 9 Sep 2002 13:29:37 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Mon, 9 Sep 2002 11:32:19 -0600
To: Linus Torvalds <torvalds@transmeta.com>
Cc: pwaechtler@mac.com, Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 10/10 sound/oss/dmasound/dmasound_q40.c
Message-ID: <20020909173219.GU7887@clusterfs.com>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	pwaechtler@mac.com,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200209091007.g89A7dZH010390@smtp-relay02.mac.com> <Pine.LNX.4.44.0209090841400.1641-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0209090841400.1641-100000@home.transmeta.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 09, 2002  09:07 -0700, Linus Torvalds wrote:
> The reasons your emails seem to be considered spammish by spamassassing 
> is:
> 
> 	tests=MSG_ID_ADDED_BY_MTA_2,NO_REAL_NAME,DATE_IN_FUTURE
> 
> That seems to have happened with patch 5/10, for example.

LOL.  My spamassassin marked 5/10 in the "P O R N_10" group, and
"DATE_IN_PAST_96_XX", but it was rescued by "UNIFIED_PATCH" and "AWL"
(spamassassin 2.31, but with some scores I set myself).  It got marked
that way because of the triple-x beside "fixme".  I have AWL set as a
pretty small negative number because people start spamming (viruses more)
with sender addresses of real people on l-k.

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

