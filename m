Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264838AbRF1XYd>; Thu, 28 Jun 2001 19:24:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265051AbRF1XYO>; Thu, 28 Jun 2001 19:24:14 -0400
Received: from pipt.oz.cc.utah.edu ([155.99.2.7]:40905 "EHLO
	pipt.oz.cc.utah.edu") by vger.kernel.org with ESMTP
	id <S264838AbRF1XYE>; Thu, 28 Jun 2001 19:24:04 -0400
Date: Thu, 28 Jun 2001 17:23:58 -0600 (MDT)
From: james rich <james.rich@m.cc.utah.edu>
To: Luigi Genoni <kernel@Expansa.sns.it>
cc: linux-kernel@vger.kernel.org
Subject: Re: Announcing Journaled File System (JFS) release 1.0.0 available
In-Reply-To: <Pine.LNX.4.33.0106290056350.27056-100000@Expansa.sns.it>
Message-ID: <Pine.GSO.4.05.10106281717430.10211-100000@pipt.oz.cc.utah.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Jun 2001, Luigi Genoni wrote:

> On Fri, 29 Jun 2001, Yaacov Akiba Slama wrote:
> 
> > So it seems that even if JFS is less complete than XFS (no ACL, quotas
> > for instance), and even if it is less robust (I don't know if it is, I
> It is not less complete nor less robust, it's a different technology and a
> totally different approach.
> Remember XFS was designed thinking to a kind of HW totally different from
> PC, and so was for jfs. But somehow JFS is a better choice if you
> do not have the last fastest CPU, and the last fastest scsi disk.

This is simply not true.  I run xfs on three systems - none of which have
anything close to the latest cpu.  Each system runs faster after
installing xfs.  Since linux-kernel is not the place for advocacy I
suggest a comparison be for your particular setup to determine which is
best for you.

James Rich
james.rich@m.cc.utah.edu

