Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263153AbVCJVad@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263153AbVCJVad (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 16:30:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263185AbVCJV2T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 16:28:19 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:1549 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263153AbVCJVVf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 16:21:35 -0500
Date: Thu, 10 Mar 2005 21:21:24 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Chris Wedgwood <cw@f00f.org>
Cc: Petr Vandrovec <vandrove@vc.cvut.cz>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: XScale 8250 patches cause malfunction on AMD-8111
Message-ID: <20050310212124.B1044@flint.arm.linux.org.uk>
Mail-Followup-To: Chris Wedgwood <cw@f00f.org>,
	Petr Vandrovec <vandrove@vc.cvut.cz>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@osdl.org>
References: <20050307174506.GA9659@vana.vc.cvut.cz> <20050307195654.GA9394@vana.vc.cvut.cz> <20050307213148.B29948@flint.arm.linux.org.uk> <20050310210506.GA13988@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050310210506.GA13988@taniwha.stupidest.org>; from cw@f00f.org on Thu, Mar 10, 2005 at 01:05:06PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 10, 2005 at 01:05:06PM -0800, Chris Wedgwood wrote:
> On Mon, Mar 07, 2005 at 09:31:48PM +0000, Russell King wrote:
> 
> > Good catch, thanks.  I'd preferably like to see Chris Wedgwood test
> > this before applying it - I'm sure it'll fix his problem as well,
> > but I'd like to be sure.
> 
> Yes, this appears to work correctly for me.  I see it's merged so this
> is just an ACK that it works, nobody actually has to do anything :-)

Thanks for that Chris.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
