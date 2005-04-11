Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261562AbVDKO0O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261562AbVDKO0O (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 10:26:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261751AbVDKO0O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 10:26:14 -0400
Received: from hera.kernel.org ([209.128.68.125]:50628 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S261562AbVDKO0J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 10:26:09 -0400
Date: Mon, 11 Apr 2005 05:39:32 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch] MAINTAINERS: remove obsolete ACP/MWAVE MODEM entry
Message-ID: <20050411083932.GE1356@logos.cnet>
References: <20050409231545.GU3632@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050409231545.GU3632@stusta.de>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian,

./drivers/char/mwave/Makefile also references Paul's email 
address, at least in v2.4.

Applied, thanks.

On Sun, Apr 10, 2005 at 01:15:45AM +0200, Adrian Bunk wrote:
> Both maintainer email addresses are bouncing and the web address is no 
> longer valid.
> 
> Seems to be a good time to remove the entry.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> --- linux-2.6.12-rc2-mm2-full/MAINTAINERS.old	2005-04-10 01:12:58.000000000 +0200
> +++ linux-2.6.12-rc2-mm2-full/MAINTAINERS	2005-04-10 01:13:14.000000000 +0200
> @@ -172,14 +172,6 @@
>  W:	http://www.stud.uni-karlsruhe.de/~uh1b/
>  S:	Maintained
>  
> -ACP/MWAVE MODEM
> -P:	Paul B Schroeder
> -M:	paulsch@us.ibm.com
> -P:	Mike Sullivan
> -M:	sullivam@us.ibm.com
> -W:	http://www.ibm.com/linux/ltc/
> -S:	Supported
> -
>  AACRAID SCSI RAID DRIVER
>  P:	Adaptec OEM Raid Solutions
>  L:	linux-scsi@vger.kernel.org
