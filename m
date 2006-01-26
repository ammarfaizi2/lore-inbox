Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751258AbWAZChv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751258AbWAZChv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 21:37:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751290AbWAZChv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 21:37:51 -0500
Received: from palrel10.hp.com ([156.153.255.245]:32910 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S1751258AbWAZChv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 21:37:51 -0500
Date: Wed, 25 Jan 2006 18:37:57 -0800
From: Grant Grundler <grundler@parisc-linux.org>
To: Akinobu Mita <mita@miraclelinux.com>
Cc: linux-kernel@vger.kernel.org, parisc-linux@parisc-linux.org
Subject: Re: [PATCH 4/6] use include/asm-generic/bitops for each architecture
Message-ID: <20060126023757.GD11843@esmail.cup.hp.com>
Reply-To: Grant Grundler <grundler@parisc-linux.org>
References: <20060125112625.GA18584@miraclelinux.com> <20060125113336.GE18584@miraclelinux.com> <20060126014934.GA6648@miraclelinux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060126014934.GA6648@miraclelinux.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2006 at 10:49:34AM +0900, Akinobu Mita wrote:
> On Wed, Jan 25, 2006 at 08:33:37PM +0900, mita wrote:
> > compile test on i386, x86_64, ppc, sparc, sparc64, alpha
> > boot test on i386, x86_64, ppc
> 
> I have fogotten attaching the changes for each archtecture.

Anyone care to do the related changes for parisc?

I can provide access to native HW if the volunteer doesn't
want to muck with cross compilers.

thanks,
grant
