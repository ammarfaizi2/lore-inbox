Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262358AbVC3R0W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262358AbVC3R0W (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 12:26:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261902AbVC3R0V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 12:26:21 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:62165 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261889AbVC3RZs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 12:25:48 -0500
To: Dave Hansen <haveblue@us.ibm.com>
cc: Paul Jackson <pj@engr.sgi.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ckrm-tech@lists.sourceforge.net,
       "Vivek Kashyap [imap]" <kashyapv@us.ibm.com>, sekharan@us.ibm.com
Reply-To: Gerrit Huizenga <gh@us.ibm.com>
From: Gerrit Huizenga <gh@us.ibm.com>
Subject: Re: [patch 0/8] CKRM: Core patch set 
In-reply-to: Your message of Wed, 30 Mar 2005 08:53:19 PST.
             <1112201599.11490.6.camel@localhost> 
Date: Wed, 30 Mar 2005 09:25:44 -0800
Message-Id: <E1DGgwq-0006eI-00@w-gerrit.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 30 Mar 2005 08:53:19 PST, Dave Hansen wrote:
> On Tue, 2005-03-29 at 23:03 -0800, Gerrit Huizenga wrote:
> > The code provides a fairly simple mechanism for adding controllers for
> > any resource type
> 
> Last time I saw the memory controller, it was 3000 lines.  Doesn't seem
> too simple to me. :)
 
 Chandra, Dave's suggestions for the memory controller makes a lot of
 sense.  Can you post the current code, ported to the patch set that
 I just posted, to linux-mm for comment?

> Can you post some of the additional controllers that you've been working
> on to the appropriate mailing lists, like linux-mm?  If the subject
> experts get a good look at the controllers, it's quite possible that
> some comments will cascade back to the core, don't you think?

 You can access the various current controllers via the ckrm-tech
 archives from sf.net/projects/ckrm today.

 However, if there are additional changes to the core, I'd like to
 see them as patches built on top of this core set.  Resending the
 modified core each time makes it hard for people to see what has
 changed from release to release, where individual patches will help
 track modifications better.

gerrit
