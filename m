Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264882AbUFHHZp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264882AbUFHHZp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 03:25:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264879AbUFHHZp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 03:25:45 -0400
Received: from khan.acc.umu.se ([130.239.18.139]:43998 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id S264882AbUFHHZo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 03:25:44 -0400
Date: Tue, 8 Jun 2004 09:25:40 +0200
From: David Weinehall <tao@acc.umu.se>
To: John Cherry <cherry@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.7-rc3 (compile stats)
Message-ID: <20040608072540.GG26838@khan.acc.umu.se>
Mail-Followup-To: John Cherry <cherry@osdl.org>,
	Linus Torvalds <torvalds@osdl.org>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0406071227400.2550@ppc970.osdl.org> <1086654534.15465.4.camel@cherrybomb.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1086654534.15465.4.camel@cherrybomb.pdx.osdl.net>
User-Agent: Mutt/1.4.1i
X-Accept-Language: Swedish, English
X-GPG-Fingerprint: 7ACE 0FB0 7A74 F994 9B36  E1D1 D14E 8526 DC47 CA16
X-GPG-Key: http://www.acc.umu.se/~tao/files/pubkey_dc47ca16.gpg.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 07, 2004 at 05:28:54PM -0700, John Cherry wrote:
> I am running the sparse regressions on -rc3 as well.  Will post them on
> the compile regression site when they are complete.
> 
> ----------------------------------------
> 
> Linux 2.6 Compile Statistics (gcc 3.2.2)
> Warnings/Errors Summary
> 
> Kernel         bzImage    bzImage  bzImage  modules  bzImage   modules
>              (defconfig)  (allno)  (allyes) (allyes) (allmod) (allmod)
> -----------  -----------  -------- -------- -------- -------- ---------
> 2.6.7-rc3      0w/0e       0w/0e   108w/ 0e   5w/0e   2w/0e    104w/0e
...
> 2.6.0          0w/0e       0w/0e   170w/ 0e  12w/0e   3w/0e    209w/0e

A quite impressive improvement.

Nice going, everyone!


Regards: David Weinehall
-- 
 /) David Weinehall <tao@acc.umu.se> /) Northern lights wander      (\
//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
\)  http://www.acc.umu.se/~tao/    (/   Full colour fire           (/
