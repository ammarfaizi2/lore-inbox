Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261523AbSLHRnb>; Sun, 8 Dec 2002 12:43:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261524AbSLHRnb>; Sun, 8 Dec 2002 12:43:31 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:50053 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S261523AbSLHRna>;
	Sun, 8 Dec 2002 12:43:30 -0500
Date: Sun, 8 Dec 2002 17:48:22 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Z F <mail4me9999@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: CPU cache problem
Message-ID: <20021208174822.GA13371@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Z F <mail4me9999@yahoo.com>, linux-kernel@vger.kernel.org
References: <20021207043158.45345.qmail@web20420.mail.yahoo.com> <20021208173816.GB12941@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021208173816.GB12941@suse.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 08, 2002 at 05:38:16PM +0000, Dave Jones wrote:
 >  > As far as I know, the CPU has 128K L2 cache.
 >  > The kernel version installed on my computer is 2.4.18.
 > This bug is fixed in Marcelo's current tree, fix will be in 2.4.20pre1

*sigh, long weekend..*  I meant 2.4.21pre1 of course.
You can also find the patch at 
ftp://ftp.kernel.org/pub/linux/kernel/people/davej/patches/2.4/2.4.20/descriptors.diff


		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
