Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262805AbVF3GZK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262805AbVF3GZK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 02:25:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262858AbVF3GZK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 02:25:10 -0400
Received: from wproxy.gmail.com ([64.233.184.206]:62770 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262805AbVF3GZD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 02:25:03 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:cc:in-reply-to:references:message-id:mime-version:content-type:content-transfer-encoding:x-mailer;
        b=NmhkRiSEIzYIBDKebjIimwdlEyLMaaidKWPGu1ntPv8dICPw1wyc4YrBO6MVcjqmodbtUv9xraLGdieyl2gn/wnyTsAM/U0eBahqe9icCDONg8ZuHwE/XVJzhYznj2nPJFZ2BuQOdLgYlHtBnFqFy5n+wTcblpM71ZIjA92hubw=
Date: Thu, 30 Jun 2005 14:22:16 +0800
From: Wang Jian <larkwang@gmail.com>
To: randy_dunlap <rdunlap@xenotime.net>
Subject: Re: 2.6.12.1 problems I meet (please CC: me)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050629230020.28a1c129.rdunlap@xenotime.net>
References: <20050630111916.FEA2.LARKWANG@gmail.com> <20050629230020.28a1c129.rdunlap@xenotime.net>
Message-Id: <20050630141344.FEA5.LARKWANG@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.20 [CN]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry,

I am not intended to do that. gmail's pop server has problem of not
sending response after final "." is sent. And my email client keeps trying
to send it out in thinking that sending failed.

Actually, I manually stopped it before you complain coz I was afraid it
sent duplicate copies, and check gmail account's outbox via web. It
seems that only one copy is sent out and I am relieved. But it is not
true, it did send 3 copies.

Sorry again.


On Wed, 29 Jun 2005 23:00:20 -0700
randy_dunlap <rdunlap@xenotime.net> wrote:

> On Thu, 30 Jun 2005 13:52:18 +0800 Wang Jian wrote:
> 
> | Hi,
> | 
> | I use a customized kernel to do packets analysis. The analysis code is
> | linked into kernel. It will vmalloc() nearly 128M (a little less) when
> | initialized.
> | 
> 
> OK, we have your message 3 times now, so please stop sending it.
> 
> ---
> ~Randy

-- 
Wang Jian

