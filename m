Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932085AbWAEPjJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932085AbWAEPjJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 10:39:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932100AbWAEPjI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 10:39:08 -0500
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:57006 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S932085AbWAEPi7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 10:38:59 -0500
Subject: Re: oops pauser. / boot_delayer
From: Avishay Traeger <atraeger@cs.sunysb.edu>
To: Mark Lord <lkml@rtr.ca>
Cc: gcoady@gmail.com, Bernd Eckenfels <be-news06@lina.inka.de>,
       linux-kernel@vger.kernel.org, davej@redhat.com
In-Reply-To: <43BD3BEC.5060309@rtr.ca>
References: <20060104221023.10249eb3.rdunlap@xenotime.net>
	 <E1EuPZg-0008Kw-00@calista.inka.de>
	 <6appr1djnkhaa35cjahs22itittduia9bf@4ax.com>  <43BD3BEC.5060309@rtr.ca>
Content-Type: text/plain
Date: Thu, 05 Jan 2006 10:38:50 -0500
Message-Id: <1136475531.21485.97.camel@rockstar.fsl.cs.sunysb.edu>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-01-05 at 10:31 -0500, Mark Lord wrote:
> Grant Coady wrote:
> >
> > No, after oops, console dead, very dead . . . no scrollback :(
> 
> This mis-feature is beginning to annoy more and more.
> 
> I seem to recall that "in the old days" (1990s),
> this was NOT the case:  scrollback still worked from oops.

I am able to scroll up on the console for most regular oopses, but not
panics.  Am I missing something here?

Avishay Traeger
http://www.fsl.cs.sunysb.edu/~avishay/

