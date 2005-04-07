Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262405AbVDGJq1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262405AbVDGJq1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 05:46:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262408AbVDGJq1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 05:46:27 -0400
Received: from fire.osdl.org ([65.172.181.4]:24231 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262405AbVDGJqR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 05:46:17 -0400
Date: Thu, 7 Apr 2005 02:46:05 -0700
From: Andrew Morton <akpm@osdl.org>
To: Paul Mackerras <paulus@samba.org>
Cc: dwmw2@infradead.org, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: Kernel SCM saga..
Message-Id: <20050407024605.35515dcc.akpm@osdl.org>
In-Reply-To: <16980.64324.87931.513333@cargo.ozlabs.ibm.com>
References: <Pine.LNX.4.58.0504060800280.2215@ppc970.osdl.org>
	<1112858331.6924.17.camel@localhost.localdomain>
	<20050407015019.4563afe0.akpm@osdl.org>
	<16980.64324.87931.513333@cargo.ozlabs.ibm.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Mackerras <paulus@samba.org> wrote:
>
> With -mm we get those nice little automatic emails saying you've put
>  the patch into -mm, which removes one of the main reasons for wanting
>  to be able to get an up-to-date image of your tree.

Should have done that ages ago..

>  The other reason,
>  of course, is to be able to see if a patch I'm about to send conflicts
>  with something you have already taken, and rebase it if necessary.

<hack, hack>

How's this?


This is a note to let you know that I've just added the patch titled

     ppc32: Fix AGP and sleep again

to the -mm tree.  Its filename is

     ppc32-fix-agp-and-sleep-again.patch

Patches currently in -mm which might be from yourself are

add-suspend-method-to-cpufreq-core.patch
ppc32-fix-cpufreq-problems.patch
ppc32-fix-agp-and-sleep-again.patch
ppc32-fix-errata-for-some-g3-cpus.patch
ppc64-fix-semantics-of-__ioremap.patch
ppc64-improve-mapping-of-vdso.patch
ppc64-detect-altivec-via-firmware-on-unknown-cpus.patch
ppc64-remove-bogus-f50-hack-in-promc.patch
