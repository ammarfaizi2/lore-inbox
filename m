Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266898AbUIES0h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266898AbUIES0h (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 14:26:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266901AbUIES0g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 14:26:36 -0400
Received: from serenity.mcc.ac.uk ([130.88.200.93]:11012 "EHLO
	serenity.mcc.ac.uk") by vger.kernel.org with ESMTP id S266898AbUIES0f
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 14:26:35 -0400
Date: Sun, 5 Sep 2004 19:26:34 +0100
From: John Levon <levon@movementarian.org>
To: Anton Blanchard <anton@samba.org>
Cc: akpm@osdl.org, phil.el@wanadoo.fr, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Speed up oprofile buffer drain code
Message-ID: <20040905182634.GA41958@compsoc.man.ac.uk>
References: <20040904174403.GC7716@krispykreme> <20040904174642.GD7716@krispykreme> <20040904175737.GE7716@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040904175737.GE7716@krispykreme>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Graham Coxon - Happiness in Magazines
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *1C41ik-0001MO-U4*TXbbsEiFtC2*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 05, 2004 at 03:57:37AM +1000, Anton Blanchard wrote:

> John does this look OK to you?

Could we please rename timers_enable/start_cpu_timers()/end_cpu_timers()
now there's no timer?

Other than that looks great.

thanks
john
