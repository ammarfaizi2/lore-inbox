Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264949AbUD2Txx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264949AbUD2Txx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 15:53:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264951AbUD2Txw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 15:53:52 -0400
Received: from cfcafw.SGI.COM ([198.149.23.1]:51286 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S264949AbUD2Txr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 15:53:47 -0400
Date: Thu, 29 Apr 2004 14:53:30 -0500
From: Erik Jacobson <erikj@subway.americas.sgi.com>
To: Christoph Hellwig <hch@lst.de>
cc: Paul Jackson <pj@sgi.com>, chrisw@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Process Aggregates (PAGG) support for the 2.6 kernel
In-Reply-To: <20040429192909.GA29725@lst.de>
Message-ID: <Pine.SGI.4.53.0404291447220.732952@subway.americas.sgi.com>
References: <Pine.SGI.4.53.0404261656230.591647@subway.americas.sgi.com>
 <20040426163955.X21045@build.pdx.osdl.net> <Pine.SGI.4.53.0404271546410.632984@subway.americas.sgi.com>
 <20040428145503.GA999@lst.de> <20040429122026.2ad7884e.pj@sgi.com>
 <20040429192909.GA29725@lst.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> without merging anything that actually uses pagg getting pagg itself
> into the kernel doesn't make a lot of sense.

We have job and CSA that make use of it but I didn't know if I should
push them all at the same time, or one at a time.  As it is, the suggestions
provided for PAGG are making for some significant revisions.  The changes
require adjustments to job as well.

I'm hoping to get something with nearly all the suggestions implemented for
PAGG posted, then I can post job if you think that will help.  I'm sure
there will be lots of comments on that as well -- and those comments will
probably require revisions to CSA :-)

If you're saying there really is zero chance even if I implement all the
suggestions and have things that use it, I guess I'll just have to live with
that (what's my other choice? :). At least the patches will be better off
even if they exist as patches forever.  We're really hoping we can get this in
though...  So I want to do everything I can to give it the best shot possible.

--
Erik Jacobson - Linux System Software - Silicon Graphics - Eagan, Minnesota
