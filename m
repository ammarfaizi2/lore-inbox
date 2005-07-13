Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262407AbVGMGVQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262407AbVGMGVQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 02:21:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262505AbVGMGVQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 02:21:16 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:65039 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262407AbVGMGVP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 02:21:15 -0400
Date: Wed, 13 Jul 2005 07:21:11 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.6.13-rc3
Message-ID: <20050713072111.C19871@flint.arm.linux.org.uk>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0507122157070.17536@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.58.0507122157070.17536@g5.osdl.org>; from torvalds@osdl.org on Tue, Jul 12, 2005 at 10:05:00PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2005 at 10:05:00PM -0700, Linus Torvalds wrote:
>  it's _really_ -rc3 this time, never mind the confusion with the commit 
> message last time (when the Makefile clearly said -rc2, but my over-eager 
> fingers had typed in a commit message saying -rc3).
> 
> There's a bit more changes here than I would like, but I'm putting my foot 
> down now. Not only are a lot of people going to be gone next week for LKS 
> and OLS, but we've gotten enough stuff for 2.6.13, and we need to calm 
> down.

What does this mean as far as my broken repositories thanks to your
broken git?  If there's going to be a break in all kernel development
for kernel summit/OLS, I would like to see -rc4 with my changes in
beforehand, as compensation for giving me such a hard time with git
repositories.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
