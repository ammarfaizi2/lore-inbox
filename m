Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261713AbVCJVF4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261713AbVCJVF4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 16:05:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262968AbVCJVF4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 16:05:56 -0500
Received: from pimout1-ext.prodigy.net ([207.115.63.77]:21177 "EHLO
	pimout1-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S261713AbVCJVFq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 16:05:46 -0500
Date: Thu, 10 Mar 2005 13:05:06 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Petr Vandrovec <vandrove@vc.cvut.cz>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: XScale 8250 patches cause malfunction on AMD-8111
Message-ID: <20050310210506.GA13988@taniwha.stupidest.org>
References: <20050307174506.GA9659@vana.vc.cvut.cz> <20050307195654.GA9394@vana.vc.cvut.cz> <20050307213148.B29948@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050307213148.B29948@flint.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 07, 2005 at 09:31:48PM +0000, Russell King wrote:

> Good catch, thanks.  I'd preferably like to see Chris Wedgwood test
> this before applying it - I'm sure it'll fix his problem as well,
> but I'd like to be sure.

Yes, this appears to work correctly for me.  I see it's merged so this
is just an ACK that it works, nobody actually has to do anything :-)
