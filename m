Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262485AbTCIJaX>; Sun, 9 Mar 2003 04:30:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262486AbTCIJaW>; Sun, 9 Mar 2003 04:30:22 -0500
Received: from tag.witbe.net ([81.88.96.48]:22279 "EHLO tag.witbe.net")
	by vger.kernel.org with ESMTP id <S262485AbTCIJaW>;
	Sun, 9 Mar 2003 04:30:22 -0500
From: "Paul Rolland" <rol@as2917.net>
To: "'Paul Larson'" <plars@linuxtestproject.org>,
       "'Rusty Lynch'" <rusty@linux.co.intel.com>
Cc: "'lkml'" <linux-kernel@vger.kernel.org>
Subject: Re: Available watchdog test cases
Date: Sun, 9 Mar 2003 10:40:58 +0100
Message-ID: <008501c2e61f$fdd0a800$2101a8c0@witbe>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
In-Reply-To: <1046880939.26974.21.camel@plars>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just a quick question : is there an easy to force the kernel to Oops,
to make sure that the watchdog will even be working under such
conditions ?

I know people are all trying to avoid Oops... but I think the testplan
should include that too...

Regards,
Paul

> On Tue, 2003-03-04 at 15:04, Rusty Lynch wrote:
> > The test cases that I have been using for testing my 
> watchdog work are 
> > available at 
> > http://www.stinkycat.com/patches/watchdog_stuff/watchdog_test.tar.gz
> > 
> > The test are for both the legacy (well, current) /dev/watchdog 
> > interface and my proposed sysfs based interface.
> Thanks a bunch Rusty, I'll take a look at them for LTP.

