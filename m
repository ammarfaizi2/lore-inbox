Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262048AbTKLLmr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Nov 2003 06:42:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262050AbTKLLmr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Nov 2003 06:42:47 -0500
Received: from intra.cyclades.com ([64.186.161.6]:25807 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S262048AbTKLLmp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Nov 2003 06:42:45 -0500
Date: Wed, 12 Nov 2003 09:39:00 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Peter Adebahr <adsys@adebahr.de>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.23-pre9 ide+XFree+ptrace=Complete hang
In-Reply-To: <Pine.LNX.4.44.0311120928380.14144-100000@logos.cnet>
Message-ID: <Pine.LNX.4.44.0311120938510.14144-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 12 Nov 2003, Marcelo Tosatti wrote:

> 
> 
> On Tue, 11 Nov 2003, Peter Adebahr wrote:
> 
> > On Tue, 11 Nov 2003, Maciej Zenczykowski wrote:
> > 
> > > This is a very vague bug report... however this is something which
> > > definetely shouldn't be happening.  This is more a question as to whether
> > > such an issue is known and if not, how should I go about fixing it...
> > 
> > Hi Maciej,
> > 
> > I am also experiencing some strange hangups, without having had the
> > time to investigate them. Nothing in syslog, but a sure way NOT to
> > have problems: I have run all 2.4.23-pre kernels, and this has
> > definitely started with -pre7. Everything until -pre6 was fine.
> > 
> > My feeling tells me it has to do with DRM, so I built the -rc1-pac1
> > kernel about three hours ago, without any hickups so far.
> 
> Peter,
> 
> What hardware are you using?

dmesg also. 

