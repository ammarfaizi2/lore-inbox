Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263795AbUGHPH0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263795AbUGHPH0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 11:07:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263831AbUGHPHZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 11:07:25 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:60653 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263795AbUGHPGa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 11:06:30 -0400
Date: Thu, 8 Jul 2004 11:45:06 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Leszek Koltunski <leszek@serwer.3miasto.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: the old 'Unknown HZ value' bug
Message-ID: <20040708144506.GA6809@logos.cnet>
References: <Pine.NEB.4.60.0407080250190.5702@serwer.3miasto.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.NEB.4.60.0407080250190.5702@serwer.3miasto.net>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 08, 2004 at 02:57:04AM +0200, Leszek Koltunski wrote:
> 
> I keep getting the bug at random times. My googling resulted in a bunch of 
> posts claiming that the problem is related to SMP systems and possibly to 
> uptime. But not in my case- I do not have a SMP system and I sometimes get 
> the bug right after bootup. SMP support is turned off, as you can see in 
> my config:
> 
> www.3miasto.net/~leszek/config.html
> 
> I was getting it with 2.4.17, 2.4.24, and every single 2.6.x .
> ( I haven't tested other 2.4.x's )

Leszek, 

Can you please your problem in more detail?
