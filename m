Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265886AbSLNUTI>; Sat, 14 Dec 2002 15:19:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265890AbSLNUTI>; Sat, 14 Dec 2002 15:19:08 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:61580 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S265886AbSLNUTH>;
	Sat, 14 Dec 2002 15:19:07 -0500
Date: Sat, 14 Dec 2002 20:26:36 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Stephen Torri <storri@sbcglobal.net>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Unresolved symbols in agpart
Message-ID: <20021214202636.GA4274@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Stephen Torri <storri@sbcglobal.net>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <1039896536.963.7.camel@base.torri.linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1039896536.963.7.camel@base.torri.linux>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 14, 2002 at 02:08:56PM -0600, Stephen Torri wrote:
 > I would like to help clear up the module problem in the linux kernel
 > (2.5.51). The problem I am getting is when I do "make install" there is
 > a report back that some symbols are unresolved. What I need to know is
 > how these symbols are supposed to be exported? I can grep the files to
 > find the symbols and correct this problem.

Can you try with the patch at
ftp://ftp.kernel.org/pub/linux/kernel/people/davej/patches/2.5/2.5.51/

and let me know if that fixes things ?

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
