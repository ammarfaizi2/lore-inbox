Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751898AbWHUOnU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751898AbWHUOnU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 10:43:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751899AbWHUOnT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 10:43:19 -0400
Received: from stout.engsoc.carleton.ca ([134.117.69.22]:53702 "EHLO
	stout.engsoc.carleton.ca") by vger.kernel.org with ESMTP
	id S1751898AbWHUOnT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 10:43:19 -0400
Date: Mon, 21 Aug 2006 10:42:22 -0400
From: Kyle McMartin <kyle@mcmartin.ca>
To: Adrian Bunk <bunk@stusta.de>
Cc: matthew@wil.cx, grundler@parisc-linux.org, kyle@parisc-linux.org,
       linux-kernel@vger.kernel.org, parisc-linux@parisc-linux.org
Subject: Re: [parisc-linux] [2.6 patch] parisc: "extern inline" -> "static inline"
Message-ID: <20060821144222.GC14544@athena.road.mcmartin.ca>
References: <20060819171930.GJ7813@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060819171930.GJ7813@stusta.de>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 19, 2006 at 07:19:30PM +0200, Adrian Bunk wrote:
> If there are places that really need a forced inline, __always_inline 
> would be the correct solution.
> 

ACK, Ok.

> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 

Acked-by: Kyle McMartin <kyle@parisc-linux.org>
