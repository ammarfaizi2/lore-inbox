Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268074AbUHQCCk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268074AbUHQCCk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 22:02:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268075AbUHQCCk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 22:02:40 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:14490 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S268074AbUHQCCj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 22:02:39 -0400
Subject: Re: boot time, process start time, and NOW time
From: Lee Revell <rlrevell@joe-job.com>
To: James Courtier-Dutton <James@superbug.demon.co.uk>
Cc: Albert Cahalan <albert@users.sf.net>, george@mvista.com,
       Albert Cahalan <albert@users.sourceforge.net>,
       Tim Schmielau <tim@physik3.uni-rostock.de>,
       Andrew Morton OSDL <akpm@osdl.org>,
       OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
       lkml <linux-kernel@vger.kernel.org>, voland@dmz.com.pl,
       nicolas.george@ens.fr, kaukasoi@elektroni.ee.tut.fi,
       johnstul@us.ibm.com, david+powerix@blue-labs.org
In-Reply-To: <41216566.8040206@superbug.demon.co.uk>
References: <1087948634.9831.1154.camel@cube>
	 <87smcf5zx7.fsf@devron.myhome.or.jp>
	 <20040816124136.27646d14.akpm@osdl.org>
	 <Pine.LNX.4.53.0408170055180.14122@gockel.physik3.uni-rostock.de>
	 <412151CA.4060902@mvista.com> <1092695544.2301.1227.camel@cube>
	 <41215EDA.3070802@mvista.com> <1092697717.2301.1233.camel@cube>
	 <41216566.8040206@superbug.demon.co.uk>
Content-Type: text/plain
Message-Id: <1092708212.13981.135.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 16 Aug 2004 22:03:32 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-08-16 at 21:54, James Courtier-Dutton wrote:
> Albert Cahalan wrote:

> While on the subject of time, is it possible to get a monotonic timer 
> with 1ms or better resolution?

mplayer uses /dev/rtc for this.  Any reason why it won't work for you?

Lee

