Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750935AbWHJTOL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750935AbWHJTOL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 15:14:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750984AbWHJTOL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 15:14:11 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:13969 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1750852AbWHJTOL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 15:14:11 -0400
Date: Thu, 10 Aug 2006 21:14:00 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, john stultz <johnstul@us.ibm.com>
Subject: Re: [NTP 8/9] convert to the NTP4 reference model
In-Reply-To: <20060810114903.089825bc.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0608102106180.6761@scrub.home>
References: <20060810000146.913645000@linux-m68k.org> <20060810001115.525351000@linux-m68k.org>
 <20060810114903.089825bc.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 10 Aug 2006, Andrew Morton wrote:

> > This converts the kernel ntp model into a model which matches the
> > nanokernel reference implementations.
> 
> For the ntp ignorami amongst us...  what is a "nanokernel reference
> implementation" and why do we want one?

It's the behaviour the current ntp daemon expects, the ntp documentation 
has more information and a link to the package (e.g. under Debian at 
/usr/share/doc/ntp-doc/html/kern.html).

bye, Roman
