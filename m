Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270806AbTHAP2J (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 11:28:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270807AbTHAP2J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 11:28:09 -0400
Received: from modemcable166.48-200-24.mtl.mc.videotron.ca ([24.200.48.166]:35770
	"EHLO xanadu.home") by vger.kernel.org with ESMTP id S270806AbTHAP2F
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Aug 2003 11:28:05 -0400
Date: Fri, 1 Aug 2003 11:27:47 -0400 (EDT)
From: Nicolas Pitre <nico@cam.org>
X-X-Sender: nico@xanadu.home
To: John Bradford <john@grabjohn.com>
cc: rob@landley.net, lkml <linux-kernel@vger.kernel.org>,
       <szepe@pinerecords.com>
Subject: Re: Messing with Kconfig.
In-Reply-To: <200308010901.h7191Wsd000946@81-2-122-30.bradfords.org.uk>
Message-ID: <Pine.LNX.4.44.0308011112310.9934-100000@xanadu.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Aug 2003, John Bradford wrote:

> > So I'm looking at menuconfig and contemplating rearranging the heck out of it
> 
> Please don't.  This comes up from time to time on the mailing list,
> and massive re-arrangements are usually a Bad Thing.

Of course "massive" re-arrangements all at once have always been rejected,
and we've seen obvious examples of that in the kernel build/config system
area already.

One should have learned, though, that small incremental changes can achieve
similar results and are much more acceptable to the rest of the community.


Nicolas

