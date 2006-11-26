Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967342AbWKZIto@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967342AbWKZIto (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Nov 2006 03:49:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967339AbWKZIto
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Nov 2006 03:49:44 -0500
Received: from 1wt.eu ([62.212.114.60]:59652 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S967342AbWKZItn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Nov 2006 03:49:43 -0500
Date: Sun, 26 Nov 2006 09:49:10 +0100
From: Willy Tarreau <w@1wt.eu>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH-2.4] fbcon: incorrect use of "&&" instead of "&"
Message-ID: <20061126084910.GB13909@1wt.eu>
References: <20061125212209.GA5918@1wt.eu> <Pine.LNX.4.62.0611260933160.4055@pademelon.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0611260933160.4055@pademelon.sonytel.be>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 26, 2006 at 09:33:30AM +0100, Geert Uytterhoeven wrote:
> On Sat, 25 Nov 2006, Willy Tarreau wrote:
> > I'm about to merge this in 2.4. Do you have any objection ?
> 
> No.
> 
> Acked-By: Geert Uytterhoeven <geert@linux-m68k.org>

Fine, applied.
Thanks Geert !

Willy

