Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277435AbRKMRux>; Tue, 13 Nov 2001 12:50:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277568AbRKMRun>; Tue, 13 Nov 2001 12:50:43 -0500
Received: from cx570538-a.elcjn1.sdca.home.com ([24.5.14.144]:30084 "EHLO
	keroon.dmz.dreampark.com") by vger.kernel.org with ESMTP
	id <S277435AbRKMRue>; Tue, 13 Nov 2001 12:50:34 -0500
Message-ID: <3BF15D63.10D9948C@randomlogic.com>
Date: Tue, 13 Nov 2001 09:50:27 -0800
From: "Paul G. Allen" <pgallen@randomlogic.com>
Organization: Akamai Technologies, Inc.
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.7-ac10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Chris Abbey <linux@cabbey.net>
CC: "Linux kernel developer's mailing list" 
	<linux-kernel@vger.kernel.org>,
        "kplug-lpsg@kernel-panic.org" <kplug-lpsg@kernel-panic.org>
Subject: Re: Missing source files for standard libraries
In-Reply-To: <Pine.LNX.4.33.0111130036270.13264-100000@tweedle.cabbey.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Abbey wrote:
> 
> Yesterday, Paul G. Allen wrote:
> > I'm working on a game engine and there's a bug (actually, more than one
> > ;) causing seg faults within different functions in the C/C++ libraries
> > (e.g. - stdlib). I installed all the development stuff from the Red Hat
> > CD's, do I need to get the gcc source or something in order to get these
> > files?
> 
> most likely you need the glibc-devel package, or potentially the glibc
> sources, I'm not sure how RH packages it... but in either case stdlib
> is user space, not kernel space, so wrong list. ;)
> 


I knew between the two lists, someone would know. I installed the
glibc-devel package though.

PGA
-- 
Paul G. Allen
UNIX Admin II/Network Security
Akamai Technologies, Inc.
www.akamai.com
