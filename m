Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932083AbVLaBkl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932083AbVLaBkl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 20:40:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932082AbVLaBkl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 20:40:41 -0500
Received: from wscnet.wsc.cz ([212.80.64.118]:45193 "EHLO wscnet.wsc.cz")
	by vger.kernel.org with ESMTP id S932085AbVLaBkk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 20:40:40 -0500
Message-ID: <43B5E191.3030705@gmail.com>
Date: Sat, 31 Dec 2005 02:40:33 +0100
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: cs, en-us, en
MIME-Version: 1.0
To: Mathias Klein <ma_klein@gmx.de>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: oops in kernel 2.6.15-rc7
References: <20051230194435.GA7088@sidney>
In-Reply-To: <20051230194435.GA7088@sidney>
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mathias Klein napsal(a):
> Hello,
> 
> i recently got another oops. As suggested by Pekka Enberg I've enabled
> CONFIG_DEBUG_SLAB and CONFIG_DEBUG_PAGEALLOC.
[snip]
> Dec 30 20:12:11 sidney kernel: [31895.553014] Oops: 0000 [#1]
> Dec 30 20:12:11 sidney kernel: [31895.553065] PREEMPT 
btw. this is not kernel with CONFIG_DEBUG_PAGEALLOC.

regards,
-- 
Jiri Slaby         www.fi.muni.cz/~xslaby
\_.-^-._   jirislaby@gmail.com   _.-^-._/
B67499670407CE62ACC8 22A032CC55C339D47A7E
