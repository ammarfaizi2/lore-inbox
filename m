Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267490AbUIJQPM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267490AbUIJQPM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 12:15:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267540AbUIJQMT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 12:12:19 -0400
Received: from dsl017-059-236.wdc2.dsl.speakeasy.net ([69.17.59.236]:36046
	"EHLO marta.kurtwerks.com") by vger.kernel.org with ESMTP
	id S267490AbUIJQKZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 12:10:25 -0400
Date: Fri, 10 Sep 2004 12:14:32 -0400
From: Kurt Wall <kwall@kurtwerks.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Latest microcode data from Intel.
Message-ID: <20040910161432.GF10104@kurtwerks.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <4141CAAB.4020708@tmr.com> <Pine.LNX.4.44.0409101641220.1294-100000@einstein.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0409101641220.1294-100000@einstein.homenet>
User-Agent: Mutt/1.4.2.1i
X-Operating-System: Linux 2.4.26
X-Woot: Woot!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In a 1.5K blaze of typing glory, Tigran Aivazian wrote:
> On Fri, 10 Sep 2004, Bill Davidsen wrote:
> 
> > Tigran Aivazian wrote:
> > > Hello,
> > > 
> > > I have received and tested the latest microcode data file from Intel, The
> > > file is dated 2nd September 2004. You can download it both as standalone
> > > (bzip2-ed) text file and bundled with microcode_ctl utility from the
> > > Download section of the website:
> > > 
> > > http://urbanmyth.org/microcode/
> > > 
> > > Please let me know if you find any problems with this data file or with
> > > the Linux microcode driver. Thank you.
> > 
> > Why are you using /dev/cpu/microcode instead of /dev/cpu/N/microcode for 
> > each CPU? Today they are all the same device, but for the future I would 
> > think this was an obvious CYA.
> 
> I have two questions:
> 
> 1. What does "CYA" mean?

Cover Your Ass.

[snippage]

Kurt
-- 
Green light in a.m. for new projects.  Red light in P.M. for traffic
tickets.
