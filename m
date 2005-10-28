Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030632AbVJ1SnF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030632AbVJ1SnF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 14:43:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030631AbVJ1SnF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 14:43:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:6045 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030632AbVJ1SnE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 14:43:04 -0400
From: Andi Kleen <ak@suse.de>
To: Pavel Machek <pavel@suse.cz>
Subject: Re: [PATCH] Disable the most annoying printk in the kernel
Date: Fri, 28 Oct 2005 20:43:57 +0200
User-Agent: KMail/1.8.2
Cc: vojtech@suse.cz, akpm@osdl.org, linux-kernel@vger.kernel.org
References: <200510271026.10913.ak@suse.de> <20051028072003.GB1602@openzaurus.ucw.cz>
In-Reply-To: <20051028072003.GB1602@openzaurus.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510282043.58025.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 28 October 2005 09:20, Pavel Machek wrote:
> Hi!
> 
> > Remove most useless printk in the world
> > 
> > Signed-off-by: Andi Kleen <ak@suse.de>
> 
> It warns about crappy keyboards. It triggers regulary for me on x32,
> (probably because of my weird capslock+x+s etc combination). It is
> usefull as a warning "this keyboard is crap" and "no, bad mechanical switch
> is not the reason for lost key".

In German that would be described as "Zum Schaden auch noch den Spot"
(for the damage you get the gossip too). Not very useful.

-Andi
