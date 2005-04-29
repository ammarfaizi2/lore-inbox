Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262978AbVD2Vwd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262978AbVD2Vwd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 17:52:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262980AbVD2Vwc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 17:52:32 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:60345 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S262978AbVD2Vw3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 17:52:29 -0400
Subject: Re: i386 'make install' behavior change
From: Dave Hansen <haveblue@us.ibm.com>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>
In-Reply-To: <20050429205443.GA8699@mars.ravnborg.org>
References: <1114797161.9140.22.camel@localhost>
	 <20050429205443.GA8699@mars.ravnborg.org>
Content-Type: text/plain
Date: Fri, 29 Apr 2005 14:52:24 -0700
Message-Id: <1114811544.9140.51.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-04-29 at 22:54 +0200, Sam Ravnborg wrote:
> On Fri, Apr 29, 2005 at 10:52:41AM -0700, Dave Hansen wrote:
> > Hi Sam,
> > 
> > I noticed in 2.6.12-rc3 that 'make install' doesn't depend on vmlinux.
> > I first noticed this in -mm, and it was discussed a bit here:
> > 
> > http://marc.theaimsgroup.com/?l=linux-kernel&m=111083577531995&w=2
> > 
> > Could you please push that patch to Linus before 2.6.12 finalizes?
> 
> It's on the plate for this weekend.

Great!  Just wanted to make sure it hadn't been dropped.

-- Dave

