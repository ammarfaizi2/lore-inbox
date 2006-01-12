Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161465AbWALX05@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161465AbWALX05 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 18:26:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161456AbWALX05
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 18:26:57 -0500
Received: from cabal.ca ([134.117.69.58]:37250 "EHLO fattire.cabal.ca")
	by vger.kernel.org with ESMTP id S1161465AbWALX04 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 18:26:56 -0500
Date: Thu, 12 Jan 2006 18:25:44 -0500
From: Kyle McMartin <kyle@mcmartin.ca>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Adrian Bunk <bunk@stusta.de>, Matthew Wilcox <willy@parisc-linux.org>,
       linux-kernel@vger.kernel.org, parisc-linux@parisc-linux.org
Subject: Re: [parisc-linux] Re: [2.6 patch] arch/parisc/Makefile: remove GCC_VERSION
Message-ID: <20060112232544.GA9429@quicksilver.road.mcmartin.ca>
References: <20060112105157.GT29663@stusta.de> <20060112215237.GC8665@mars.ravnborg.org> <20060112215409.GD4701@quicksilver.road.mcmartin.ca> <20060112223500.GA9079@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060112223500.GA9079@mars.ravnborg.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2006 at 11:35:00PM +0100, Sam Ravnborg wrote:
> Andrew & I did it in most cases, and Adrian cleaned up parisc and killed
> the last instance og GCC_VERSION there.
> 
> No functional changes, but a nice cleanup.
>

OK. Ack that, then, I'll merge it in my tree.

Cheers,
	Kyle 
