Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261497AbUCQOkq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 09:40:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261524AbUCQOkq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 09:40:46 -0500
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:5637 "EHLO
	kerberos.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S261497AbUCQOko (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 09:40:44 -0500
Subject: Re: 2.6.5-rc1-mm1 reboots before the boot completes
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Helge Hafting <helgehaf@aitel.hist.no>,
       Kernel Mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <20040317021531.70191854.akpm@osdl.org>
References: <20040316015338.39e2c48e.akpm@osdl.org>
	 <405823B2.7070500@aitel.hist.no>  <20040317021531.70191854.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1079534385.2182.4.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-1) 
Date: Wed, 17 Mar 2004 15:39:45 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-03-17 at 11:15, Andrew Morton wrote:
> Helge Hafting <helgehaf@aitel.hist.no> wrote:
> >
> >  2.6.5-rc1-mm1 didn't come up for me.
> 
> yes, there's something bad in there.
> 
> Does it help if you revert ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.5-rc1/2.6.5-rc1-mm1/broken-out/early-x86-cpu-detection-fix.patch ?

Yep! Indeed it does :-)

