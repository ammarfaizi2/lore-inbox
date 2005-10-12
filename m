Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751479AbVJLQIO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751479AbVJLQIO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 12:08:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751480AbVJLQIO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 12:08:14 -0400
Received: from mgw-ext04.nokia.com ([131.228.20.96]:7100 "EHLO
	mgw-ext04.nokia.com") by vger.kernel.org with ESMTP
	id S1751479AbVJLQIN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 12:08:13 -0400
Subject: Re: Nokia 770 kernel sources?
From: Kai Svahn <kai.svahn@nokia.com>
To: ext Jon Masters <jonathan@jonmasters.org>
Cc: Tony Lindgren <tony@atomide.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20051011135739.GA22484@apogee.jonmasters.org>
References: <35fb2e590510101708l497a44a5oe71971e9c3c925a9@mail.gmail.com>
	 <20051011134936.GA12462@atomide.com>
	 <20051011135739.GA22484@apogee.jonmasters.org>
Content-Type: text/plain
Date: Wed, 12 Oct 2005 19:08:47 +0300
Message-Id: <1129133327.22381.29.camel@six.research.nokia.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 Oct 2005 16:08:07.0625 (UTC) FILETIME=[225FAB90:01C5CF47]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, 2005-10-11 at 14:57 +0100, ext Jon Masters wrote:
> On Tue, Oct 11, 2005 at 04:49:38PM +0300, Tony Lindgren wrote:
> 
> > * Jon Masters <jonmasters@gmail.com> [051011 03:09]:
> > > Hi folks,
> > > 
> > > Anyone know if a vanilla 2.6 omap1 kernel is supposed to "just work" on the 770?
> > 
> > A lot of the 770 stuff already been merged, but there are
> > still some more patches coming. So you should be able to use
> > the linux-omap tree at some point.
> 
> I'd like to use it now as I've got a 770 that I'd like to play with.
The kernel sources for N770 will be available in www.maemo.org when we
start sales. There will be some binary modules that will not be made
open source. All drivers we can open source, we will, and they will be
pushed to linux-omap tree and into mainstream kernel through driver
specific channels. Unfortunately all open source drivers are not yet in
linux-omap tree so you cannot compile your own kernel for N770, I'm
sorry about that. 

-Kai

