Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262009AbUCVOrQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 09:47:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262010AbUCVOrP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 09:47:15 -0500
Received: from fed1mtao04.cox.net ([68.6.19.241]:22182 "EHLO
	fed1mtao04.cox.net") by vger.kernel.org with ESMTP id S262009AbUCVOrP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 09:47:15 -0500
Date: Mon, 22 Mar 2004 07:47:10 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Matt Mackall <mpm@selenic.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] minor fix to kgdboe configuration logic
Message-ID: <20040322144710.GB27175@smtp.west.cox.net>
References: <20040321004618.GV11010@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040321004618.GV11010@waste.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 20, 2004 at 06:46:19PM -0600, Matt Mackall wrote:

> This seems to have gotten dropped. Without it, kgdboe can get into a
> half-configured state.
> 
> kgdboe - fix configuration of MAC address
> 
> 
>  tiny-mpm/drivers/net/kgdb_eth.c |    7 ++++---
>  1 files changed, 4 insertions(+), 3 deletions(-)

Thanks, applied.

-- 
Tom Rini
http://gate.crashing.org/~trini/
