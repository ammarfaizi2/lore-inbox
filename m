Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264884AbUD2Q4C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264884AbUD2Q4C (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 12:56:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264893AbUD2Q4B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 12:56:01 -0400
Received: from fire.osdl.org ([65.172.181.4]:50081 "EHLO fire-2.osdl.org")
	by vger.kernel.org with ESMTP id S264884AbUD2Qz7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 12:55:59 -0400
Subject: Re: Linux 2.6.6-rc3
From: Craig Thomas <craiger@osdl.org>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040429005959.GB5692@zip.com.au>
References: <Pine.LNX.4.58.0404271858290.10799@ppc970.osdl.org>
	 <1083200520.1923.111.camel@bullpen.pdx.osdl.net>
	 <20040429005959.GB5692@zip.com.au>
Content-Type: text/plain
Message-Id: <1083258653.1923.159.camel@bullpen.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 29 Apr 2004 10:10:53 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-04-28 at 17:59, CaT wrote:
> On Wed, Apr 28, 2004 at 06:02:00PM -0700, Craig Thomas wrote:
> > On Tue, 2004-04-27 at 19:03, Linus Torvalds wrote:
> > > s390, cifs, ntfs, ppc, ppc64, cpufreq upates. Oh, and DVB and USB.
> > > 
> > > I'm hoping to do a final 2.6.6 later this week, so I'm hoping as many 
> > > people as possible will test this.
> > 
> > OSDL is nearly complete with their automated tests.  Tests 
> > completed so far:
> 
> Would it be possible to get results for the latest 2.4 to compare it
> with? To see if it looks like it's doing better, worse or thesame. 2.4
> comes out less often so it shouldn't be much of a hassle (right? :)

Done and posted.  

The DBT3-pgsql test will fail on 2.4 at this time due to LVM2
and PostgreSQL interoperability issues with the 2.6 kernel.  We
have been focusing on the 2.6 kernel, so we have not had a chance to
get that test working on 2.4, but if anyone wants to fix it for 2.4,
we'll be more than happy to run it.

