Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266869AbUGVSBH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266869AbUGVSBH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 14:01:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266881AbUGVR7L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 13:59:11 -0400
Received: from sccrmhc11.comcast.net ([204.127.202.55]:18857 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S266869AbUGVR4c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 13:56:32 -0400
Date: Thu, 22 Jul 2004 10:56:17 -0700
From: Deepak Saxena <dsaxena@plexity.net>
To: Jesse Stockall <stockall@magma.ca>
Cc: Greg KH <greg@kroah.com>, Oliver Neukum <oliver@neukum.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] delete devfs
Message-ID: <20040722175617.GA5724@plexity.net>
Reply-To: dsaxena@plexity.net
References: <20040721141524.GA12564@kroah.com> <200407211626.55670.oliver@neukum.org> <20040721145208.GA13522@kroah.com> <1090444782.8033.4.camel@homer.blizzard.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1090444782.8033.4.camel@homer.blizzard.org>
Organization: Plexity Networks
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 21 2004, at 17:19, Jesse Stockall was caught saying:
> On Wed, 2004-07-21 at 10:52, Greg KH wrote:
> > 
> > And as Lars points out, the code is unmaintained, unused, and buggy.
> > All good reasons to rip out it out at any moment in time.
> 
> Unused? Since when does every Linux user use a vendor supplied kernel? I
> have no use for devfs, never used it in the past, and I'm a happy udev
> user now, but that doesn't change the fact that there are many devfs
> users out there.

If the devfs user community really wants to keep using devfs, they can
volunteer to maintain it as a separate project & patch.

> What does this gain us right now?

A single maintained solution/implementation for a given problem in the
main tree. This is a good thing.

~Deepak

-- 
Deepak Saxena - dsaxena at plexity dot net - http://www.plexity.net/

"Unlike me, many of you have accepted the situation of your imprisonment and
 will die here like rotten cabbages." - Number 6
