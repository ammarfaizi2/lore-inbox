Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281537AbRKMGjP>; Tue, 13 Nov 2001 01:39:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281542AbRKMGjF>; Tue, 13 Nov 2001 01:39:05 -0500
Received: from 24.159.204.122.roc.nc.chartermi.net ([24.159.204.122]:13830
	"EHLO tweedle.cabbey.net") by vger.kernel.org with ESMTP
	id <S281537AbRKMGjC>; Tue, 13 Nov 2001 01:39:02 -0500
Date: Tue, 13 Nov 2001 00:38:23 -0600 (CST)
From: Chris Abbey <linux@cabbey.net>
X-X-Sender: <cabbey@tweedle.cabbey.net>
To: "Paul G. Allen" <pgallen@randomlogic.com>
cc: "Linux kernel developer's mailing list" 
	<linux-kernel@vger.kernel.org>,
        "kplug-lpsg@kernel-panic.org" <kplug-lpsg@kernel-panic.org>
Subject: Re: Missing source files for standard libraries
In-Reply-To: <3BF0BBB2.76DFCA3@randomlogic.com>
Message-ID: <Pine.LNX.4.33.0111130036270.13264-100000@tweedle.cabbey.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yesterday, Paul G. Allen wrote:
> I'm working on a game engine and there's a bug (actually, more than one
> ;) causing seg faults within different functions in the C/C++ libraries
> (e.g. - stdlib). I installed all the development stuff from the Red Hat
> CD's, do I need to get the gcc source or something in order to get these
> files?

most likely you need the glibc-devel package, or potentially the glibc
sources, I'm not sure how RH packages it... but in either case stdlib
is user space, not kernel space, so wrong list. ;)


-- 
now the forces of openness have a powerful and
  unexpected new ally - http://ibm.com/linux

Need it? Get it! http://ibm.com/developerworks

