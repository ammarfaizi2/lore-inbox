Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287941AbSABUUe>; Wed, 2 Jan 2002 15:20:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287944AbSABUUZ>; Wed, 2 Jan 2002 15:20:25 -0500
Received: from relay-3m.club-internet.fr ([195.36.216.172]:5513 "HELO
	relay-3m.club-internet.fr") by vger.kernel.org with SMTP
	id <S287941AbSABUUK>; Wed, 2 Jan 2002 15:20:10 -0500
Message-ID: <3C336B65.2020905@freesurf.fr>
Date: Wed, 02 Jan 2002 21:19:49 +0100
From: Kilobug <kilobug@freesurf.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7+) Gecko/20011228
X-Accept-Language: fr-fr, fr, en
MIME-Version: 1.0
To: timothy.covell@ashavan.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: system.map
In-Reply-To: <20020102191157.49760.qmail@web21204.mail.yahoo.com> <200201021930.g02JUCSr021556@svr3.applink.net> <3C336209.8000808@nothing-on.tv> <200201022006.g02K6vSr021827@svr3.applink.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 5. sync;sync;shutdown -r now

Is there any particular reason for this double sync ? One isn't enough ?
(And is sync even needed with shutdown, all should be synced when 
filesystems are unmounted or remounted read-only, am I wrong ? )

-- 
** Gael Le Mignot "Kilobug", Ing3 EPITA - http://kilobug.free.fr **
Home Mail   : kilobug@freesurf.fr          Work Mail : le-mig_g@epita.fr
GSM         : 06.71.47.18.22 (in France)   ICQ UIN   : 7299959
Fingerprint : 1F2C 9804 7505 79DF 95E6 7323 B66B F67B 7103 C5DA

"Software is like sex it's better when it's free.", Linus Torvalds

