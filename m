Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261658AbUBYV7G (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 16:59:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261636AbUBYVxy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 16:53:54 -0500
Received: from waste.org ([209.173.204.2]:2024 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261644AbUBYVxN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 16:53:13 -0500
Date: Wed, 25 Feb 2004 15:52:40 -0600
From: Matt Mackall <mpm@selenic.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>,
       "Amit S. Kale" <akale@users.sourceforge.net>
Subject: Re: 3/3 kgdb over netpoll
Message-ID: <20040225215240.GE3883@waste.org>
References: <20040222160849.GA9563@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040222160849.GA9563@elf.ucw.cz>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 22, 2004 at 05:08:49PM +0100, Pavel Machek wrote:
> Hi!
> 
> This is kgdb-over-ethernet patch. Depends on netpoll, and is somehow
> experimental.

Please pick up the current kgdboe docs from -mm.

-- 
Matt Mackall : http://www.selenic.com : Linux development and consulting
