Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265563AbUFDChC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265563AbUFDChC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 22:37:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265569AbUFDChC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 22:37:02 -0400
Received: from mail8.fw-bc.sony.com ([160.33.98.75]:57819 "EHLO
	mail8.fw-bc.sony.com") by vger.kernel.org with ESMTP
	id S265563AbUFDCgx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 22:36:53 -0400
Message-ID: <40BFE083.2030600@am.sony.com>
Date: Thu, 03 Jun 2004 19:37:55 -0700
From: Tim Bird <tim.bird@am.sony.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.4) Gecko/20030624 Netscape/7.1 (ax)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Wedgwood <cw@f00f.org>
CC: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.6.6 add qsort library function (UPDATED PATCH, symbol
 exported _GPL)
References: <20040510050733.GA13889@taniwha.stupidest.org> <20040510071552.GB30834@taniwha.stupidest.org>
In-Reply-To: <20040510071552.GB30834@taniwha.stupidest.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wedgwood wrote:

>  [ This is an updated patch where the symbol is exported GPL only
>    recognized the GPL origin in the code used.  Thanks for those
>    people who pointed this out. ]

> +EXPORT_SYMBOL_GPL(qsort);

I'm sorry, but I don't see the connection.  Just because the code
is GPL, why should a caller be constrained to be GPL?
Is there something about the qsort API that makes a caller
intrinsically a derivative work?

=============================
Tim Bird
Architecture Group Co-Chair
CE Linux Forum
Senior Staff Engineer
Sony Electronics
E-mail: Tim.Bird@am.sony.com
=============================

