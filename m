Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269787AbUICUQk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269787AbUICUQk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 16:16:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269767AbUICUOI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 16:14:08 -0400
Received: from steffenspage.de ([213.9.79.102]:65192 "EHLO
	mail.steffenspage.de") by vger.kernel.org with ESMTP
	id S269776AbUICUDR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 16:03:17 -0400
From: Steffen Zieger <lkml@steffenspage.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Codemercs IO-Warrior support
Date: Fri, 3 Sep 2004 22:03:18 +0200
User-Agent: KMail/1.7
References: <200409032114.08743.lkml@steffenspage.de> <20040903194211.GA5546@hsnr.de>
In-Reply-To: <20040903194211.GA5546@hsnr.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409032203.20240.lkml@steffenspage.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 03 September 2004 21:42, Juergen Quade wrote:
> A few weeks ago I had a closer look at the source code of
> this driver. Sorry, but it contains some serious erros -
> in my opinion it has to be rewritten from scratch :-(
Won't disagree with you, but the patch for hid-core.c could be added in my 
opinion, because it only makes sure, that the IO-Warrior isn't handled by 
hid.

> Just my 2 cents,
>
>           Juergen.
>
Greetz,
Steffen
