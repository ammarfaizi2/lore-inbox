Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262948AbVDHUZa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262948AbVDHUZa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 16:25:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262949AbVDHUYT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 16:24:19 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:1465 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262948AbVDHURC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 16:17:02 -0400
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc2-V0.7.44-00
From: Lee Revell <rlrevell@joe-job.com>
To: "K.R. Foley" <kr@cybsft.com>
Cc: Rui Nuno Capela <rncbc@rncbc.org>, Steven Rostedt <rostedt@goodmis.org>,
       Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <4256E671.4040303@cybsft.com>
References: <20050325145908.GA7146@elte.hu> <20050331085541.GA21306@elte.hu>
	 <20050401104724.GA31971@elte.hu> <20050405071911.GA23653@elte.hu>
	 <46802.192.168.1.5.1112727980.squirrel@www.rncbc.org>
	 <1112729762.5147.62.camel@localhost.localdomain>
	 <39754.192.168.1.5.1112973759.squirrel@www.rncbc.org>
	 <1112980542.10271.4.camel@mindpipe>  <4256E671.4040303@cybsft.com>
Content-Type: text/plain
Date: Fri, 08 Apr 2005 16:17:01 -0400
Message-Id: <1112991421.11000.39.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-04-08 at 15:15 -0500, K.R. Foley wrote:
> Lee Revell wrote:
> > On Fri, 2005-04-08 at 16:22 +0100, Rui Nuno Capela wrote:
> > 
> >>>Our first victim!! :-)
> >>>
> >>
> >>No kidding!?
> >>
> > 
> > 
> > V0.7.44-02 does not even compile for me.  It appears to be full of merge
> > errors.
> > 
> 
> I must be in the twilight zone over here. V0.7.44-02 runs fine on my UP 
> system, my older SMP system (although I have to compile in my SCSI 
> drivers, but that has nothing to do with this patch) and my faster P4/HT 
> SMP system at the office.

Meh, I'll try again, maybe it's some weird NFS problem.

Lee

