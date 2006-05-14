Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932362AbWENDs7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932362AbWENDs7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 May 2006 23:48:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932368AbWENDs7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 May 2006 23:48:59 -0400
Received: from ylpvm01-ext.prodigy.net ([207.115.57.32]:25580 "EHLO
	ylpvm01.prodigy.net") by vger.kernel.org with ESMTP id S932362AbWENDs6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 May 2006 23:48:58 -0400
X-ORBL: [69.149.117.205]
Date: Sat, 13 May 2006 22:43:46 -0500
From: Michael Halcrow <lkml@halcrow.us>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, michael.craig.thompson@gmail.com,
       phillip@hellewell.homeip.net, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, viro@ftp.linux.org.uk,
       mhalcrow@us.ibm.com, mcthomps@us.ibm.com, toml@us.ibm.com,
       yoder1@us.ibm.com, jmorris@namei.org, sct@redhat.com, ezk@cs.sunysb.edu,
       dhowells@redhat.com
Subject: Re: [PATCH 0/13: eCryptfs] eCryptfs Patch Set
Message-ID: <20060514034346.GA4427@halcrow.us>
Reply-To: Michael Halcrow <lkml@halcrow.us>
References: <20060513033742.GA18598@hellewell.homeip.net> <44655ECD.10404@yahoo.com.au> <afcef88a0605130921k7139da13k1b7232acb29140c1@mail.gmail.com> <44669D12.5050306@yahoo.com.au> <20060513201341.63590cff.akpm@osdl.org> <4466A37F.4030601@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4466A37F.4030601@yahoo.com.au>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 14, 2006 at 01:26:55PM +1000, Nick Piggin wrote:
> Compiling at each step is better than not. But my main point is
> that it is superfluously broken into multiple patches.

This comment is from about a year ago, so it probably has fallen off
the radar:

At 2005-06-02 14:51:54, Greg K-H wrote:
> On Thu, Jun 02, 2005 at 07:32:19AM -0500, Michael Halcrow wrote:
> > What sort of
> > logical chunks would you consider to be appropriate?  Separate patches
> > for each file (inode.c, file.c, super.c, etc.), which represent sets
> > of functions for each major VFS object?
> 
> Yes.
> 
> thanks,
> 
> greg k-h
