Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264915AbUGZDfa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264915AbUGZDfa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jul 2004 23:35:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264917AbUGZDfa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jul 2004 23:35:30 -0400
Received: from mail.aspec.ru ([217.14.198.4]:57868 "EHLO mail.aspec.ru")
	by vger.kernel.org with ESMTP id S264915AbUGZDf0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jul 2004 23:35:26 -0400
Message-ID: <41047BF6.1040403@belkam.com>
Date: Mon, 26 Jul 2004 08:35:18 +0500
From: Dmitry Melekhov <dm@belkam.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.4) Gecko/20030630
X-Accept-Language: ru, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.26, sundance, oops
References: <40FB9119.5030507@belkam.com> <40FBA854.5050102@belkam.com>
In-Reply-To: <40FBA854.5050102@belkam.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Melekhov wrote:

> Hello!
>
> btw, I just got following:
>
> NETDEV WATCHDOG: eth1: transmit timed out
> eth1: Transmit timed out, TxStatus 00 TxFrameId 1e, resetting...

OK. Just because there is no replies, I changed driver to
sundance.c:v1.11 2/4/2003  Written by Donald Becker

And it works for 5 days without any problem- no transmit timeouts, no 
oopses.


