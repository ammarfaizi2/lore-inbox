Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264159AbUD0VAm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264159AbUD0VAm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 17:00:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264352AbUD0VAm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 17:00:42 -0400
Received: from cfcafw.sgi.com ([198.149.23.1]:36989 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S264159AbUD0VAl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 17:00:41 -0400
Date: Tue, 27 Apr 2004 16:00:32 -0500
From: Erik Jacobson <erikj@subway.americas.sgi.com>
To: Chris Wright <chrisw@osdl.org>
cc: Jesse Barnes <jbarnes@sgi.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Process Aggregates (PAGG) support for the 2.6 kernel
In-Reply-To: <20040426174102.S22989@build.pdx.osdl.net>
Message-ID: <Pine.SGI.4.53.0404271552040.632984@subway.americas.sgi.com>
References: <Pine.SGI.4.53.0404261656230.591647@subway.americas.sgi.com>
 <20040426163955.X21045@build.pdx.osdl.net> <200404261736.47522.jbarnes@sgi.com>
 <20040426174102.S22989@build.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Nothing aside from what's on ckrm.sf.net.  I know they've been retooling
> it a bit, but I'm not up on the current status.

The web site contains API docs and some out-dated patches.  I joined the
mailing list and asked for the latest stuff.  They told me they'd be posting
a new patch to their mailing list soon.

I expect the "new" stuff uses the virtual filesystem interface and other
things suggested by the API docs they have.

I plan to look at this in more detail when I have the latest stuff to
think about.

My first impression is that pagg itself could be used to implement parts of
what ckrm is doing if they desired and not necessarily the other way around.

It's not clear to me if this is something that will be accepted in to the
main kernel source or not.

I'll post again when I learn more about it and can form a better opinion.

--
Erik Jacobson - Linux System Software - Silicon Graphics - Eagan, Minnesota
