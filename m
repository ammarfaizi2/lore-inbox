Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266441AbUFQKDr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266441AbUFQKDr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 06:03:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266442AbUFQKDq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 06:03:46 -0400
Received: from bart.webpack.hosteurope.de ([217.115.142.76]:59307 "EHLO
	bart.webpack.hosteurope.de") by vger.kernel.org with ESMTP
	id S266441AbUFQKDp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 06:03:45 -0400
Envelope-to: linux-kernel@vger.kernel.org
Date: Thu, 17 Jun 2004 12:09:23 +0200 (CEST)
From: Martin Diehl <lists@mdiehl.de>
X-X-Sender: martin@notebook.home.mdiehl.de
To: Christoph Hellwig <hch@infradead.org>
cc: Oliver Neukum <oliver@neukum.org>, <davids@webmaster.com>,
       <erikharrison@gmail.com>, <linux-kernel@vger.kernel.org>
Subject: Re: more files with licenses that aren't GPL-compatible
In-Reply-To: <20040617075926.GA27938@infradead.org>
Message-ID: <Pine.LNX.4.44.0406171201100.7337-100000@notebook.home.mdiehl.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-HE-MXrcvd: no
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Jun 2004, Christoph Hellwig wrote:

> On Thu, Jun 17, 2004 at 12:45:32AM +0200, Oliver Neukum wrote:
> > This all boils down to the question of whether fimware is code or not.
> 
> No, that's exactly the political discussion we don't want to discuss here.
> The keyspan case is worse where a file used in the kernel built has a
> GPL-incompatible license.

>From a technical point of view I'm just wondering how it comes this 
firmware is derived from the Linux kernel? I mean this is running on an 
8-bit microcontroller with some 4KiB of memory so it sounds pretty much 
impossible to me.

If anybody would have a point calling this a derived work from Linux, I'd 
be very concerned about SCO might have a point with their claims wrt. 
Linux being derived from their IP =(:-(

>From the maintenance POV of course it would be much better not to have it 
aggregated with the kernel sources.

SCNR
Martin

