Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268073AbTBMP6O>; Thu, 13 Feb 2003 10:58:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268069AbTBMP6N>; Thu, 13 Feb 2003 10:58:13 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:41627 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S268073AbTBMP6N>;
	Thu, 13 Feb 2003 10:58:13 -0500
Date: Thu, 13 Feb 2003 16:03:00 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Paul Larson <plars@linuxtestproject.org>
Cc: Edesio Costa e Silva <edesio@ieee.org>,
       lkml <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>,
       Edesio Costa e Silva <edesio@task.com.br>
Subject: Re: 2.5.60 cheerleading...
Message-ID: <20030213160300.GB2070@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Paul Larson <plars@linuxtestproject.org>,
	Edesio Costa e Silva <edesio@ieee.org>,
	lkml <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@transmeta.com>,
	Edesio Costa e Silva <edesio@task.com.br>
References: <3E4A6DBD.8050004@pobox.com> <1045075415.22295.46.camel@plars> <20030212173300.A31055@master.softaplic.com.br> <1045150153.28493.10.camel@plars>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1045150153.28493.10.camel@plars>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 13, 2003 at 09:29:12AM -0600, Paul Larson wrote:
 > It would be nice if that were true, but back here in reality things are
 > rarely if ever even stable enough for testing if they merely build and
 > boot.
 > 
 > If Linus really is building and booting every kernel prior to release,
 > it would be quick and simple to add a fast subset of LTP to the mix and
 > do a quick regression run.  It's convenient, fast and could save a lot
 > of headaches for a lot of people later on.

Nothing stops people from LTPtesting the -bk nightlies.
Sure, they won't catch the last-minute-torvalds-breaks-the-compile
type bugs, but for the most part it should be useful enough info.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
