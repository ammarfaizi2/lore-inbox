Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261872AbTLAH6e (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Dec 2003 02:58:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262052AbTLAH6e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Dec 2003 02:58:34 -0500
Received: from kweetal.tue.nl ([131.155.3.6]:4626 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S261872AbTLAH6d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Dec 2003 02:58:33 -0500
Date: Mon, 1 Dec 2003 08:58:24 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: William Lee Irwin III <wli@holomorphy.com>,
       James W McMechan <mcmechanjw@juno.com>, linux-kernel@vger.kernel.org
Subject: Re: Oops with tmpfs on both 2.4.22 & 2.6.0-test11
Message-ID: <20031201075824.GA6068@win.tue.nl>
References: <20031130.131750.-1591395.3.mcmechanjw@juno.com> <20031201012126.GN8039@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031201012126.GN8039@holomorphy.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 30, 2003 at 05:21:26PM -0800, William Lee Irwin III wrote:
> On Sun, Nov 30, 2003 at 01:17:46PM -0800, James W McMechan wrote:
> > Unable to handle kernel paging request at virtual address 00200200
> > c018a152
> > *pde = 00000000
> > Oops: 0002 [#1]
> > CPU:    0
> > EIP:    0060:[<c018a152>]    Not tainted
> 
> This is significantly different in nature from the 2.4 oops, since
> 2.4 hit NULL and this pointer is total garbage.
> 
> Either it's a double bitflip or even worse is afoot.

This oops is completely understood. I was going to write to you
yesterday evening, but then saw that Oleg Drokin already had
written. Didnt you see his mail?

