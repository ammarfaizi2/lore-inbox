Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261348AbVFAWV0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261348AbVFAWV0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 18:21:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261195AbVFAWTU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 18:19:20 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:30921 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261334AbVFAWPI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 18:15:08 -0400
Subject: Re: 2.6.12-rc5-mm2 JFS problems ?
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Dave Kleikamp <shaggy@austin.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1117663508.8097.6.camel@localhost>
References: <OF808D1EE8.D03EF4CB-ON05257013.006A4FEB-05257013.006AA085@us.ibm.com>
	 <1117661821.26913.1591.camel@dyn318077bld.beaverton.ibm.com>
	 <1117663508.8097.6.camel@localhost>
Content-Type: text/plain
Organization: 
Message-Id: <1117662856.26913.1608.camel@dyn318077bld.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 01 Jun 2005 14:54:20 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-06-01 at 15:05, Dave Kleikamp wrote:
> On Wed, 2005-06-01 at 14:37 -0700, Badari Pulavarty wrote:
> > On Wed, 2005-06-01 at 12:24, David Kleikamp wrote:
> > > pbadari@us.ltcfwd.linux.ibm.com wrote on 06/01/2005 12:30:25 PM:
> > > 
> > > > Hi Shaggy,
> > > > 
> > > > I keep running to JFS problems on 2.6.12-rc5-mm2 (never seen before).
> > > > I get following stacks while booting the machine. 
> > > > 
> > > > Known issue ?
> > > 
> > > No.  ppc64?  I'm using jfs on rc5-mm2 on i386 without any problems.
> > 
> > x86-64
> 
> I don't have that at my disposal.  I am now running rc5-mm2 on ppc64
> without any problems.

I have seen the problem only on boot. I haven't booted the machine
yet. So, I will see if I can reproduce - if its consistently
reproducible, I will let you know for debug.

Thanks,
Badari

