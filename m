Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263895AbUGFNxG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263895AbUGFNxG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jul 2004 09:53:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263923AbUGFNxG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jul 2004 09:53:06 -0400
Received: from users.linvision.com ([62.58.92.114]:53682 "HELO bitwizard.nl")
	by vger.kernel.org with SMTP id S263895AbUGFNxE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jul 2004 09:53:04 -0400
Date: Tue, 6 Jul 2004 15:53:03 +0200
From: Erik Mouw <erik@harddisk-recovery.com>
To: Redeeman <lkml@metanurb.dk>
Cc: LKML Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: quite big breakthrough in the BAD network performance, which mm6 did not fix
Message-ID: <20040706135303.GG20237@harddisk-recovery.com>
References: <1089070720.14870.6.camel@localhost> <200407051754.38690.lkml@lpbproductions.com> <1089120330.10626.8.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1089120330.10626.8.camel@localhost>
User-Agent: Mutt/1.3.28i
Organization: Harddisk-recovery.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 06, 2004 at 03:25:30PM +0200, Redeeman wrote:
> i am aware of this, however, what i use to benchmark is kernel.org, as i
> can see they have alot bandwith free.
> if i use kernel.org http i get 50kb/s, if i use ftp, i can easily fetch
> with 200kb/s

That could be easily explained by the fact that the www.kernel.org ftp
and http services are handled by different programs (vsftpd vs.
Apache).


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
