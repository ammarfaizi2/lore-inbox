Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262380AbUEFOjv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262380AbUEFOjv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 10:39:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262381AbUEFOjv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 10:39:51 -0400
Received: from fw.osdl.org ([65.172.181.6]:46278 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262380AbUEFOju (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 10:39:50 -0400
Date: Thu, 6 May 2004 07:39:31 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrey Panin <pazke@donpac.ru>, Andrew Morton <akpm@osdl.org>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] DMI cleanup patches
In-Reply-To: <20040506102904.GA3295@pazke>
Message-ID: <Pine.LNX.4.58.0405060738430.3271@ppc970.osdl.org>
References: <20040506102904.GA3295@pazke>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 6 May 2004, Andrey Panin wrote:
> 
> currently arch/i386/kernel/dmi_scan.c file looks like complete
> mess. Interfacing with other kernel subsystem made using
> ad-hoc ways, mostly with ugly global variables, additionaly
> coding style is ... not good. So these patches appear:

The patches look good by me, but I'd rather leave them to after 2.6.6, 
since they seem to be cleanups rather than serious bug-fixes.

Andrew?

		Linus
