Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317778AbSHUDVy>; Tue, 20 Aug 2002 23:21:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317782AbSHUDVy>; Tue, 20 Aug 2002 23:21:54 -0400
Received: from codepoet.org ([166.70.99.138]:22726 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S317778AbSHUDVx>;
	Tue, 20 Aug 2002 23:21:53 -0400
Date: Tue, 20 Aug 2002 21:26:02 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Jeff Chua <jchua@fedex.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.20-pre4 + LVM = hosed /proc/partitions
Message-ID: <20020821032601.GA12306@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Jeff Chua <jchua@fedex.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <20020821030430.GA11994@codepoet.org> <Pine.LNX.4.44.0208211118270.6828-100000@boston.corp.fedex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0208211118270.6828-100000@boston.corp.fedex.com>
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux 2.4.18-rmk7, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed Aug 21, 2002 at 11:21:04AM +0800, Jeff Chua wrote:
> 
> On Tue, 20 Aug 2002, Erik Andersen wrote:
> 
> > On Tue Aug 20, 2002 at 08:27:32PM -0600, Erik wrote:
> > > Try compiling CONFIG_BLK_DEV_LVM into 2.4.20-pre4 and then run
> > > 'cat /proc/partitions' for some amusement. I really like the way
> >
> > It also seems to occur for md and ataraid.
> 
> You should consider switching to LVM2. LVM2 doesn't have such problem, and
> it seems more stable too.

I'm not actually using it.  Just compiled it in and saw wierd
stuff happening...

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
