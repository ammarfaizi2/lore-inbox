Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268526AbUJPBH6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268526AbUJPBH6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 21:07:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268527AbUJPBH6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 21:07:58 -0400
Received: from holomorphy.com ([207.189.100.168]:57998 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S268526AbUJPBH5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 21:07:57 -0400
Date: Fri, 15 Oct 2004 18:07:49 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Kendall Bennett <KendallB@scitechsoft.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Generic VESA framebuffer driver and Video card BOOT?
Message-ID: <20041016010749.GS5607@holomorphy.com>
References: <416FB29A.11731.1C46848@localhost> <416FEC63.2911.2A62355@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <416FEC63.2911.2A62355@localhost>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 15, 2004 at 03:27:31PM -0700, Kendall Bennett wrote:
> Also is it possible to run X on a machine that is running from a serial 
> console and have it start up on the graphics card at that point? I 
> thought about that option since then everything would be in user space, 
> but wasn't sure how that would work (plus there would be a long delay 
> between when the machine is powered on and something shows up on the 
> screen, which is generally not a good thing for consumer products).

I'm actually doing this in practice.


-- wli
