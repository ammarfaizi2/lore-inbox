Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261857AbUCDMKd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 07:10:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261860AbUCDMKc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 07:10:32 -0500
Received: from stan.yoobay.net ([62.111.67.220]:21520 "EHLO mail.authmail.net")
	by vger.kernel.org with ESMTP id S261857AbUCDMJu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 07:09:50 -0500
Date: Thu, 4 Mar 2004 14:01:29 +0100
From: Daniel Mack <daniel@zonque.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.4-rc2: scripts/modpost.c
Message-ID: <20040304130129.GE5569@zonque.dyndns.org>
References: <20040304113749.GD5569@zonque.dyndns.org> <20040304035427.727d3353.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040304035427.727d3353.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 04, 2004 at 03:54:27AM -0800, Andrew Morton wrote:
> I tried your patch the other day and had weird compilation errors with x86
> allyesconfig.   Could you check that?

I tried this patch on several hosts. Both the modpost tool and all modules
were built fine. What compilation errors did you encounter?

Daniel
