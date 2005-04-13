Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261293AbVDMK3G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261293AbVDMK3G (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 06:29:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261294AbVDMK3F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 06:29:05 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:61960 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261293AbVDMK3D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 06:29:03 -0400
Date: Wed, 13 Apr 2005 11:28:59 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Petr Baudis <pasky@ucw.cz>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, "Randy.Dunlap" <rddunlap@osdl.org>,
       Ross Vandegrift <ross@jose.lug.udel.edu>
Subject: Re: Re: [ANNOUNCE] git-pasky-0.3
Message-ID: <20050413112858.F1798@flint.arm.linux.org.uk>
Mail-Followup-To: Petr Baudis <pasky@ucw.cz>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>,
	"Randy.Dunlap" <rddunlap@osdl.org>,
	Ross Vandegrift <ross@jose.lug.udel.edu>
References: <20050409200709.GC3451@pasky.ji.cz> <Pine.LNX.4.58.0504091320490.1267@ppc970.osdl.org> <Pine.LNX.4.58.0504091404350.1267@ppc970.osdl.org> <Pine.LNX.4.58.0504091617000.1267@ppc970.osdl.org> <20050410024157.GE3451@pasky.ji.cz> <20050410162723.GC26537@pasky.ji.cz> <20050411015852.GI5902@pasky.ji.cz> <20050411135758.GA3524@pasky.ji.cz> <20050413103521.D1798@flint.arm.linux.org.uk> <20050413094619.GQ16489@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050413094619.GQ16489@pasky.ji.cz>; from pasky@ucw.cz on Wed, Apr 13, 2005 at 11:46:19AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2005 at 11:46:19AM +0200, Petr Baudis wrote:
> I'll bet at the top of this you have a mktemp error.

Indeed, thanks.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
