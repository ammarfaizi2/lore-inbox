Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266193AbUA2QNH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 11:13:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266209AbUA2QNH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 11:13:07 -0500
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:31106 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S266193AbUA2QNE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 11:13:04 -0500
Date: Thu, 29 Jan 2004 16:21:47 GMT
From: John Bradford <john@grabjohn.com>
Message-Id: <200401291621.i0TGLlHd001384@81-2-122-30.bradfords.org.uk>
To: Stephen Smoogen <smoogen@lanl.gov>, chakkerz@optusnet.com.au
Cc: Timothy Miller <miller@techsource.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1075391946.5035.17.camel@smoogen2.lanl.gov>
References: <4017F2C0.4020001@techsource.com>
 <200401291211.05461.chakkerz@optusnet.com.au>
 <1075391946.5035.17.camel@smoogen2.lanl.gov>
Subject: Re: [OT] Crazy idea:  Design open-source graphics chip
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quote from Stephen Smoogen <smoogen@lanl.gov>:
> On Wed, 2004-01-28 at 18:11, Christian Unger wrote:
> > Oh ... don't get me wrong, i think that the conceptual idea is awesome. 
> > Personally, i wouldn't know where to begin, but can the open source community 
> > compete with Nvidia and ATI? afterall this goes beyond software, it delves 
> 
> Well I think the first problem is that the idea is currently too big. If
> someone were to do this sucessfully they would make the first open cards
> something like a Trident 8900C. Something small but usable for people
> who need it. The next cards would add onto it, and so on and so on until
> you got a base that would meet the 3D ATI/Nvidia needs. Trying to aim
> for the top at the beginning is a great way to crater.

A simple framebuffer connected to the parallel port would be trivial
to make, and it would be suprisingly useful for simple applications
such as word processing.  Literally a handful of components soldered
on to a piece of stripboard and well written drivers for the
framebuffer console and X is all it would take.  No need for anything
remotely fancy at first.

John.
