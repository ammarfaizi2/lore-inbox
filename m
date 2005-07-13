Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262443AbVGMUyn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262443AbVGMUyn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 16:54:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262783AbVGMUyl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 16:54:41 -0400
Received: from mail.kroah.org ([69.55.234.183]:9390 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262741AbVGMUsJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 16:48:09 -0400
Date: Wed, 13 Jul 2005 13:47:43 -0700
From: Greg KH <greg@kroah.com>
To: Andi Kleen <ak@suse.de>
Cc: Greg KH <gregkh@suse.de>, torvalds@osdl.org, akpm@osdl.org,
       "Theodore Ts'o" <tytso@mit.edu>, suresh.b.siddha@intel.com,
       Justin Forbes <jmforbes@linuxtx.org>, linux-kernel@vger.kernel.org,
       "Randy.Dunlap" <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, stable@kernel.org,
       alan@lxorguk.ukuu.org.uk, Zwane Mwaikambo <zwane@arm.linux.org.uk>
Subject: Re: [stable] Re: [11/11] x86_64: TASK_SIZE fixes for compatibility mode processes
Message-ID: <20050713204743.GB15964@kroah.com>
References: <20050713184130.GA9330@kroah.com> <20050713184426.GM9330@kroah.com> <20050713184946.GY23737@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050713184946.GY23737@wotan.suse.de>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2005 at 08:49:47PM +0200, Andi Kleen wrote:
> On Wed, Jul 13, 2005 at 11:44:26AM -0700, Greg KH wrote:
> > -stable review patch.  If anyone has any objections, please let us know.
> 
> I think the patch is too risky for stable. I had even my doubts
> for mainline.

Ok, thanks, I've removed it out of the queue.

greg k-h
