Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932409AbWIZVMF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932409AbWIZVMF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 17:12:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932415AbWIZVME
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 17:12:04 -0400
Received: from smtp.osdl.org ([65.172.181.4]:42114 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932409AbWIZVMC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 17:12:02 -0400
Date: Tue, 26 Sep 2006 14:11:49 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jiri Slaby <jirislaby@gmail.com>
Cc: <linux-kernel@vger.kernel.org>, <support@moxa.com.tw>
Subject: Re: [PATCH 2/3] Char: mxser_new, upgrade to 1.9.1
Message-Id: <20060926141149.3e3e3a4c.akpm@osdl.org>
In-Reply-To: <87473798798444375@wsc.cz>
References: <87473798798444375@wsc.cz>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Sep 2006 13:58:58 -0700
Jiri Slaby <jirislaby@gmail.com> wrote:

> I also added printk line with info, if somebody wants to test it, he may
> contact me as I can potentially debug the driver with him or just to
> confirm it works properly.

hm, so you don't actually have a known tester for this?

<goes on a little hunt>

These people:

Bernard Pidoux <pidoux@ccr.jussieu.fr>
Sergei Organov <osv@javad.com>

appear to have the hardware and are using this driver. 

Also Denis Vlasenko <vda@ilport.com.ua>, who is a kernel developer.
 
