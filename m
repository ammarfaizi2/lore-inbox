Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263891AbTKTXaR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Nov 2003 18:30:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263895AbTKTXaR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Nov 2003 18:30:17 -0500
Received: from the-penguin.otak.com ([65.37.126.18]:3200 "EHLO
	the-penguin.otak.com") by vger.kernel.org with ESMTP
	id S263891AbTKTXaM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Nov 2003 18:30:12 -0500
Date: Thu, 20 Nov 2003 15:30:06 -0800
From: Lawrence Walton <lawrence@the-penguin.otak.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Opps on boot 2.6.0-pre9-mm4
Message-ID: <20031120233006.GA1331@the-penguin.otak.com>
References: <20031120193318.GA5578@the-penguin.otak.com> <20031120131945.3cd35911.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031120131945.3cd35911.akpm@osdl.org>
X-Operating-System: Linux 2.6.0-test9-mm4 on an i686
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Looks like it died inside the machine's BIOS.
> 
> Please try reverting the three pnp patches:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test9/2.6.0-test9-mm4/broken-out/pnp-fix-3.patch
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test9/2.6.0-test9-mm4/broken-out/pnp-fix-2.patch
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test9/2.6.0-test9-mm4/broken-out/pnp-fix-1.patch
> 
> and let us know?
> 
I reverted these and it works great!



> - Upgrade the bios
The bios is the latest so updating it would not of been a option.


-- 
*--* Mail: lawrence@otak.com
*--* Voice: 425.739.4247
*--* Fax: 425.827.9577
*--* HTTP://www.otak-k.com/~lawrence/
--------------------------------------
- - - - - - O t a k  i n c . - - - - - 


