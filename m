Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754784AbWKMOoM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754784AbWKMOoM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 09:44:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754785AbWKMOoL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 09:44:11 -0500
Received: from rtr.ca ([64.26.128.89]:60942 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1754784AbWKMOoK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 09:44:10 -0500
Message-ID: <455884B9.5020106@rtr.ca>
Date: Mon, 13 Nov 2006 09:44:09 -0500
From: Mark Lord <lkml@rtr.ca>
User-Agent: Thunderbird 1.5.0.8 (X11/20061025)
MIME-Version: 1.0
To: Shaun Q <shaun@c-think.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Dual cores on Core2Duo not detected?
References: <Pine.BSO.4.64.0611122322060.30536@ref.nmedia.net>
In-Reply-To: <Pine.BSO.4.64.0611122322060.30536@ref.nmedia.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shaun Q wrote:
> Hi there everyone --
> 
> I'm trying to build a custom kernel for using both cores of my new 
> Core2Duo E6600 processor...
> 
> I thought this was simply a matter of enabling the SMP support in the 
> kernel .config and recompiling, but when the kernel comes back up, still 
> only one core is detected.
> 
> With the default vanilla text-based SuSE 10.1 install, it does find both 
> cores...
> 
> Anyone have any pointers for me on what I might be missing?

CPU type is set to Pentium-4 or Pentium-M ?  (either works here).
