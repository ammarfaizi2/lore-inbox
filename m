Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131878AbRDGUYr>; Sat, 7 Apr 2001 16:24:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131873AbRDGUYh>; Sat, 7 Apr 2001 16:24:37 -0400
Received: from mailout06.sul.t-online.com ([194.25.134.19]:65036 "EHLO
	mailout06.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S131626AbRDGUYU>; Sat, 7 Apr 2001 16:24:20 -0400
Message-ID: <3ACF7798.B4619443@t-online.de>
Date: Sat, 07 Apr 2001 22:24:56 +0200
From: Gunther.Mayer@t-online.de (Gunther Mayer)
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3 i686)
X-Accept-Language: en
MIME-Version: 1.0
CC: linux-kernel@vger.kernel.org
Subject: Re: PATCH for Broken PCI Multi-IO in 2.4.3 (serial+parport)
In-Reply-To: <3ACECA8F.FEC9439@eunet.at> <3ACED679.7E334234@mandrakesoft.com> <20010407111419.B530@redhat.com> <3ACF5F9B.AA42F1BD@t-online.de> <3ACF6223.41F138CF@mandrakesoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> 
> Gunther Mayer wrote:
> > Hardware has always needed quirks (linux-2.4.3 has about 60 occurences
> > of the word "quirks", not to mention workaround, blacklist and other synonyms)!
> >
> > Please apply this little patch instead of wasting time by finger-pointing
> > and arguing.
> >
> > Martin, comments?
> 
> Is Martin still alive?  He hasn't been active in PCI development well
> over six months, maybe a year now.  Ivan (alpha hacker) appeared on the
> scene to fix serious PCI bridge bugs, DaveM has added some PCI DMA
> stuff, and I've added a couple driver-related things.  I haven't seen
> code from Martin in a long long time, and only a comment or two in
> recent memory.

See linux/MAINTAINERS for "PCI Subsystem", the attribute is even called:
 "Supported:      Someone is actually paid to look after this".
