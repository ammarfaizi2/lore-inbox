Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261702AbTDOPlh (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 11:41:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261706AbTDOPlh 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 11:41:37 -0400
Received: from air-2.osdl.org ([65.172.181.6]:48811 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261702AbTDOPle 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Apr 2003 11:41:34 -0400
Date: Tue, 15 Apr 2003 08:52:02 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: alan@lxorguk.ukuu.org.uk
Cc: davidsen@tmr.com, linux-kernel@vger.kernel.org
Subject: Re: oops when using hdc=ide-scsi (2.5.66)
Message-Id: <20030415085202.493ee48a.rddunlap@osdl.org>
In-Reply-To: <20030415090357.5d5586b4.skraw@ithnet.com>
References: <1049740232.2965.80.camel@dhcp22.swansea.linux.org.uk>
	<Pine.LNX.3.96.1030415002500.22538A-100000@gatekeeper.tmr.com>
	<20030415090357.5d5586b4.skraw@ithnet.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Apr 2003 09:03:57 +0200 Stephan von Krawczynski <skraw@ithnet.com> wrote:

| On Tue, 15 Apr 2003 00:27:50 -0400 (EDT)
| Bill Davidsen <davidsen@tmr.com> wrote:
| 
| > On 7 Apr 2003, Alan Cox wrote:
| > 
| > > On Llu, 2003-04-07 at 20:02, Randy.Dunlap wrote:
| > > > Hi,
| > > > 
| > > > I get this when I boot 2.5.66 and the Linux command line contains
| > > > "hdc=ide-scsi".  Yes, I know that I can remove that option (as in
| > > > "DDT"), but the kernel shouldn't do this, either.
| > > 
| > > ide_scsi is completely broken in 2.5.x. Known problem. If you need it
| > > either use 2.4 or fix it 8)
| > 
| > Is that an official position that it will not be supported? People with MO
| > drives and tape will be supported only on 2.4?

Alan, if someone is willing to spend some time on ide-scsi, can you
give hints about where to start, what to do?

Thanks,
--
~Randy
