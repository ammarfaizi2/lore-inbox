Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261506AbVBRVDS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261506AbVBRVDS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 16:03:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261452AbVBRVDS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 16:03:18 -0500
Received: from smtp109.mail.sc5.yahoo.com ([66.163.170.7]:49043 "HELO
	smtp109.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261513AbVBRVC5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 16:02:57 -0500
Date: Fri, 18 Feb 2005 21:45:55 +0100
From: "d.c" <aradorlinux@yahoo.es>
To: "Sean" <seanlkml@sympatico.ca>
Cc: tytso@mit.edu, vonbrand@inf.utfsm.cl, cfriesen@nortel.com,
       aradorlinux@yahoo.es, cs@tequila.co.jp, galibert@pobox.com,
       kernel@crazytrain.com, linux-kernel@vger.kernel.org
Subject: Re: [BK] upgrade will be needed
Message-Id: <20050218214555.1f71c2e4.aradorlinux@yahoo.es>
In-Reply-To: <4075.10.10.10.24.1108751663.squirrel@linux1>
References: <seanlkml@sympatico.ca>
	<4912.10.10.10.24.1108675441.squirrel@linux1>
	<200502180142.j1I1gJXC007648@laptop11.inf.utfsm.cl>
	<1451.10.10.10.24.1108713140.squirrel@linux1>
	<20050218162729.GA5839@thunk.org>
	<4075.10.10.10.24.1108751663.squirrel@linux1>
X-Mailer: Sylpheed version 1.9.2+svn (GTK+ 2.6.1; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Fri, 18 Feb 2005 13:34:23 -0500 (EST),
"Sean" <seanlkml@sympatico.ca> escribió:


> BK already feeds patches out at the head, surely if it's as powerful as
> you think, it could feed a free SCM too for your non-bk friends in the
> community.

Who cares, really?

1) Linux was never supposed to have a "head", but -pre/-rc diff patches

2) And more important, *nobody* works against "linus' bk head". Everyone who
    is implementing something so intrusive that needs to keep track of the
    "development head" developes again the _true_ "head" of the linux
    kernel - akpm's tree.


In fact is surprising that so many people are bitching about BK and nobody
has complained that the -mm tree is not available through a SCM system (be it free
or not), which should be a issue _much_ bigger than any problem you've with
BK. I just don't get it, in my opinion people who whines about BK is people
who just don't like BK and can't accept the fact that BK is really helping
to linux development. When RMS started GNU he had to use non-free tools
and systems to work on it because everythin else sucked or it would have been
more difficult, I don't think BK is much different in this regard.

