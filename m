Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262704AbUCJTd4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 14:33:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262785AbUCJTd4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 14:33:56 -0500
Received: from open.nlnetlabs.nl ([213.154.224.1]:21264 "EHLO
	open.nlnetlabs.nl") by vger.kernel.org with ESMTP id S262704AbUCJTdx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 14:33:53 -0500
Date: Wed, 10 Mar 2004 20:33:40 +0100
From: Miek Gieben <miekg@atoom.net>
To: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
Subject: Re: pts/X counts on
Message-ID: <20040310193340.GB2278@atoom.net>
References: <20040310190902.GA2226@atoom.net> <20040310192415.GL655@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040310192415.GL655@holomorphy.com>
User-Agent: Vim/Mutt/Linux
X-Home: www.miek.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[On 10 Mar, @20:24, William wrote in "Re: pts/X counts on ..."]
> On Wed, Mar 10, 2004 at 08:09:02PM +0100, Miek Gieben wrote:
> > It just counts on.... 
> > I'm using devfs on 2.6.4-rc3, I first noticed this in 2.6.3.
> > (all 2.6.4-rcX have it),
> > Does anybody know why this is happening?
> 
> This change in behavior was intentional. It should not affect your
> applications. The change was part of a patch that made pty's
> completely dynamic.

ah, it's a feature :-) But I'm not seeing it on all my systems....(running
2.6.3)

Thanks,

grtz Miek
