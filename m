Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266933AbTATV2D>; Mon, 20 Jan 2003 16:28:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266962AbTATV2D>; Mon, 20 Jan 2003 16:28:03 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:19211 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S266933AbTATV2C>;
	Mon, 20 Jan 2003 16:28:02 -0500
Date: Mon, 20 Jan 2003 22:37:05 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: David Schwartz <davids@webmaster.com>, david.lang@digitalinsight.com,
       dana.lacoste@peregrine.com, linux-kernel@vger.kernel.org
Subject: Re: Is the BitKeeper network protocol documented?
Message-ID: <20030120213705.GA2086@mars.ravnborg.org>
Mail-Followup-To: David Schwartz <davids@webmaster.com>,
	david.lang@digitalinsight.com, dana.lacoste@peregrine.com,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0301201129510.6894-100000@dlang.diginsite.com> <20030120134831.Q1594@schatzie.adilger.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030120134831.Q1594@schatzie.adilger.int>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The fact that BK is used creates information which WOULD NOT HAVE EXISTED
> had BK not existed.  In fact, until BK was in use by Linus, not even basic
> CVS checkin comments existed, so the metadata was in a format called
> linux-kernel mbox (if that).  So, the use of a tool like BK makes more data
> available, but people cannot be worse off than when the kernel was shipped
> as a tarball and periodic patches.  For the sake of those people who don't
> or can't use BK, just pretend BK doesn't exist and they will not be any
> worse off than a year ago.

linux.bkbits.net:8080/linux-2.5 is accessible for all, even people
developing another SCM. All incremental changes can be found there
again without any licensing issues.

And btw. no-one forces people to use BK to develop the kernel.
And the kernel is available as patches on kernel.org.

So what is the point of this thread?

	Sam
