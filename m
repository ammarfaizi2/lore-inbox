Return-Path: <linux-kernel-owner+w=401wt.eu-S1751618AbWLNBEn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751618AbWLNBEn (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 20:04:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751923AbWLNBEn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 20:04:43 -0500
Received: from hera.kernel.org ([140.211.167.34]:40966 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751618AbWLNBEm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 20:04:42 -0500
X-Greylist: delayed 4433 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Dec 2006 20:04:42 EST
To: linux-kernel@vger.kernel.org
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [RFC][PATCH 2.6.19 6/6] update modification history
Date: Wed, 13 Dec 2006 15:50:12 -0800
Organization: OSDL
Message-ID: <20061213155012.24d16a51@freekitty>
References: <457E498C.1050806@bx.jp.nec.com>
	<457E4E72.9040505@bx.jp.nec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Trace: build.pdx.osdl.net 1166053813 20080 10.8.0.228 (13 Dec 2006 23:50:13 GMT)
X-Complaints-To: abuse@osdl.org
NNTP-Posting-Date: Wed, 13 Dec 2006 23:50:13 +0000 (UTC)
X-Newsreader: Sylpheed-Claws 2.5.0-rc3 (GTK+ 2.10.6; i486-pc-linux-gnu)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Dec 2006 15:38:42 +0900
Keiichi KII <k-keiichi@bx.jp.nec.com> wrote:

> From: Keiichi KII <k-keiichi@bx.jp.nec.com>
> 
> Update modification history.
> 
> Signed-off-by: Keiichi KII <k-keiichi@bx.jp.nec.com>
> ---
> --- linux-2.6.19/drivers/net/netconsole.c	2006-12-12 14:57:45.588967500 +0900
> +++ enhanced-netconsole/drivers/net/netconsole.c.sign	2006-12-12
> 14:54:49.541965250 +0900
> @@ -15,6 +15,9 @@
>   *               generic card hooks
>   *               works non-modular
>   * 2003-09-07    rewritten with netpoll api
> + * 2006-12-12    add extended features for
> + *               dynamic configurable netconsole
> + *               by Keiichi KII <k-keiichi@bx.jp.nec.com>
>   */
> 
>  /****************************************************************
> 

We use a version control system now. The history comments in the kernel
source are considered legacy and rarely if ever changed.

If you want to see the revision history use git.


-- 
Stephen Hemminger <shemminger@osdl.org>
