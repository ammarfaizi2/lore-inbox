Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261720AbVAXWuD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261720AbVAXWuD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 17:50:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261714AbVAXWtZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 17:49:25 -0500
Received: from mail8.fw-bc.sony.com ([160.33.98.75]:13447 "EHLO
	mail8.fw-bc.sony.com") by vger.kernel.org with ESMTP
	id S261701AbVAXWsS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 17:48:18 -0500
Message-ID: <41F57B1C.6020204@am.sony.com>
Date: Mon, 24 Jan 2005 14:47:56 -0800
From: Tim Bird <tim.bird@am.sony.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Matt Mackall <mpm@selenic.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/8] core-small: Introduce CONFIG_CORE_SMALL from -tiny
References: <1.464233479@selenic.com>	 <20050123004042.09f7f8eb.akpm@osdl.org>  <20050123175204.GV12076@waste.org> <1106596845.10239.91.camel@localhost.localdomain>
In-Reply-To: <1106596845.10239.91.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> #define		SIZE_HASH(small, large)    CONFIG_CORE_SMALL ? (small):(large)

I hate to be a "ditto-head", but I like this a lot.

=============================
Tim Bird
Architecture Group Chair, CE Linux Forum
Senior Staff Engineer, Sony Electronics
=============================
