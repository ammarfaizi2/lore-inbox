Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030626AbVJ1SbH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030626AbVJ1SbH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 14:31:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030617AbVJ1SbH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 14:31:07 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:19847 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1030625AbVJ1SbF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 14:31:05 -0400
Date: Fri, 28 Oct 2005 09:20:04 +0200
From: Pavel Machek <pavel@suse.cz>
To: Andi Kleen <ak@suse.de>
Cc: vojtech@suse.cz, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Disable the most annoying printk in the kernel
Message-ID: <20051028072003.GB1602@openzaurus.ucw.cz>
References: <200510271026.10913.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200510271026.10913.ak@suse.de>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Remove most useless printk in the world
> 
> Signed-off-by: Andi Kleen <ak@suse.de>

It warns about crappy keyboards. It triggers regulary for me on x32,
(probably because of my weird capslock+x+s etc combination). It is
usefull as a warning "this keyboard is crap" and "no, bad mechanical switch
is not the reason for lost key".
				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

