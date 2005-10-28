Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030470AbVJ1SvF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030470AbVJ1SvF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 14:51:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030625AbVJ1SvF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 14:51:05 -0400
Received: from gold.veritas.com ([143.127.12.110]:13140 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S1030470AbVJ1SvE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 14:51:04 -0400
Date: Fri, 28 Oct 2005 19:50:05 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Pavel Machek <pavel@suse.cz>
cc: Andi Kleen <ak@suse.de>, vojtech@suse.cz, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Disable the most annoying printk in the kernel
In-Reply-To: <20051028072003.GB1602@openzaurus.ucw.cz>
Message-ID: <Pine.LNX.4.61.0510281947040.5112@goblin.wat.veritas.com>
References: <200510271026.10913.ak@suse.de> <20051028072003.GB1602@openzaurus.ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 28 Oct 2005 18:51:03.0768 (UTC) FILETIME=[8C04B580:01C5DBF0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Oct 2005, Pavel Machek wrote:
> 
> > Remove most useless printk in the world
> 
> It warns about crappy keyboards. It triggers regulary for me on x32,
> (probably because of my weird capslock+x+s etc combination). It is
> usefull as a warning "this keyboard is crap" and "no, bad mechanical switch
> is not the reason for lost key".

Okay, if you want a message to remind you that your keyboard is crap
several times a day, please keep your own patch to do so.  Let the
rest of the world go with Andi's patch.

Hugh
