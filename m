Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263134AbUEGRJq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263134AbUEGRJq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 May 2004 13:09:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263138AbUEGRJq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 May 2004 13:09:46 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:55561 "EHLO
	kerberos.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S263134AbUEGRJp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 May 2004 13:09:45 -0400
Subject: Re: Distributions vs kernel development
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: Kernel Mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <20040507085312.3247d70d@dell_ss3.pdx.osdl.net>
References: <20040507085312.3247d70d@dell_ss3.pdx.osdl.net>
Content-Type: text/plain
Message-Id: <1083949775.1670.1.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-1) 
Date: Fri, 07 May 2004 19:09:35 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-05-07 at 17:53, Stephen Hemminger wrote:
> After having being burned twice: first by Mandrake and supermount, and second
> by SuSe and reiserfs attributes; are any of the distributions committed to
> making sure that their distribution will run the standard kernel? (ie. 2.6.X from
> kernel.org). When running a non-vendor kernel, I need to reasonably expect that the system
> will boot and all the filesystems and standard devices are available.  I don't
> expect every startup script to run clean, or every device that has a driver
> only in the vendor kernel to work. 

Fedora Core 2 Test 3 runs beatifully with a stock kernel (I'm running
FC2T3 with a stock 2.6.6-rc3-mm2 kernel). I suggest you to take a look
at it.

