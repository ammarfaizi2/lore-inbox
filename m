Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261662AbVCGHQ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261662AbVCGHQ5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 02:16:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261661AbVCGHQ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 02:16:57 -0500
Received: from [220.248.27.114] ([220.248.27.114]:32899 "HELO soulinfo.com")
	by vger.kernel.org with SMTP id S261662AbVCGHJL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 02:09:11 -0500
Date: Mon, 7 Mar 2005 14:41:31 +0800
From: hugang@soulinfo.com
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@zip.com.au>, LKML <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH][3/3] swsusp: use non-contiguous memory
Message-ID: <20050307064131.GA31983@hugang.soulinfo.com>
References: <200503042051.54176.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503042051.54176.rjw@sisk.pl>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2005 at 08:51:53PM +0100, Rafael J. Wysocki wrote:
> From: Hu Gang <hugang@soulinfo.com>
> 
> Subject: swsusp: use non-contiguous memory on resume - ppc support
> 
> This patch contains the architecture-dependent changes for ppc
> required for using a linklist instead of an array of page backup entries
> during resume.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
  Signed-off-by: Hu Gang <hugang@soulinfo.com>
...

-- 
Hu Gang       .-.
              /v\
             // \\ 
Linux User  /(   )\  [204016]
GPG Key ID   ^^-^^   http://soulinfo.com/~hugang/hugang.asc
