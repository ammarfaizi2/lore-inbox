Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266524AbUGPLUY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266524AbUGPLUY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jul 2004 07:20:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266525AbUGPLUY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jul 2004 07:20:24 -0400
Received: from pimout2-ext.prodigy.net ([207.115.63.101]:52625 "EHLO
	pimout2-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S266524AbUGPLUW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jul 2004 07:20:22 -0400
Date: Fri, 16 Jul 2004 04:20:07 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Gene Heskett <gene.heskett@verizon.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: New mobo question
Message-ID: <20040716112007.GA14641@taniwha.stupidest.org>
References: <200407160552.27074.gene.heskett@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200407160552.27074.gene.heskett@verizon.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 16, 2004 at 05:52:27AM -0400, Gene Heskett wrote:

> I've ordered a new mobo as I'm having what appears to be data bus
> problems with this one after a rather spectacular failure of a
> gforce2 video card, memtest86 says I have a lot of errors where
> 00000020 was written, but 00000000 came back, at semi-random
> locations scattered thoughout half a gig of dimms running at half
> their rated DDR266 speed.  The last nibble of the address is always
> zero, and the next nibble is always even.

Get the board replaced.

> Is there a way to prebuild a kernel that will run on both boards?,
> this older board is a VIA82686/VIA8233 based board, a Biostar M7VIB.

If I read you correctly you're getting random corruptions all over the
place so there isn't much you an do.


  --cw
