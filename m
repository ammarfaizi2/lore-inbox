Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271278AbTHCVhR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 17:37:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271279AbTHCVhR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 17:37:17 -0400
Received: from kweetal.tue.nl ([131.155.3.6]:27666 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S271278AbTHCVhP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 17:37:15 -0400
Date: Sun, 3 Aug 2003 23:37:12 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Willy Tarreau <willy@w.ods.org>
Cc: bert hubert <ahu@ds9a.nl>, linux-kernel@vger.kernel.org, akpm@osdl.org,
       devik@cdi.cz
Subject: Re: [PATCH] Allow /dev/{,k}mem to be disabled to prevent kernel from being modified easily
Message-ID: <20030803213712.GA4114@win.tue.nl>
References: <20030803180950.GA11575@outpost.ds9a.nl> <20030803191102.GA29616@alpha.home.local> <20030803191833.GA13803@outpost.ds9a.nl> <20030803202641.GA1924@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030803202641.GA1924@alpha.home.local>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 03, 2003 at 10:26:41PM +0200, Willy Tarreau wrote:
> On Sun, Aug 03, 2003 at 09:18:33PM +0200, bert hubert wrote:
>  
> > I'll whip up a dynamic patch soonish - I'm unsure about the right location,
> > /proc/sys/ something?
> 
> hmmm something such as /proc/sys/kernel/secured ?

Too generic a name. There are many ways to secure a kernel.

