Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261466AbULYAGP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261466AbULYAGP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Dec 2004 19:06:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261467AbULYAGP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Dec 2004 19:06:15 -0500
Received: from gaz.sfgoth.com ([69.36.241.230]:17399 "EHLO gaz.sfgoth.com")
	by vger.kernel.org with ESMTP id S261466AbULYAGN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Dec 2004 19:06:13 -0500
Date: Fri, 24 Dec 2004 16:06:05 -0800
From: Mitchell Blank Jr <mitch@sfgoth.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org
Subject: Re: VM fixes [4/4]
Message-ID: <20041225000605.GB30430@gaz.sfgoth.com>
References: <20041224174156.GE13747@dualathlon.random> <20041224100147.32ad4268.davem@davemloft.net> <20041224182219.GH13747@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041224182219.GH13747@dualathlon.random>
User-Agent: Mutt/1.4.2.1i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.2.2 (gaz.sfgoth.com [127.0.0.1]); Fri, 24 Dec 2004 16:06:06 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> > Again, older Alpha's do not.
> 
> If those old cpus really supported smp in linux,

The question isn't whether those CPUs support SMP; the question is whether
it's possible to build a kernel that supports both SMP boxes and older
CPUs.

-Mitch
