Return-Path: <linux-kernel-owner+w=401wt.eu-S965175AbWLUJ7L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965175AbWLUJ7L (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 04:59:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965178AbWLUJ7L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 04:59:11 -0500
Received: from mail.atmel.fr ([81.80.104.162]:48659 "EHLO atmel-es2.atmel.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965175AbWLUJ7J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 04:59:09 -0500
Message-ID: <458A5A8B.9030900@rfo.atmel.com>
Date: Thu, 21 Dec 2006 10:57:31 +0100
From: Nicolas Ferre <nicolas.ferre@rfo.atmel.com>
Organization: atmel
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: David Brownell <david-b@pacbell.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] input/spi: add ads7843 support to ads7846 touchscreen driver
References: <4582B4F4.2050106@rfo.atmel.com> <20061220140304.af85754c.akpm@osdl.org>
In-Reply-To: <20061220140304.af85754c.akpm@osdl.org>
Content-Type: text/plain;
	charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: 8bit
X-ESAFE-STATUS: Mail clean
X-ESAFE-DETAILS: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton a écrit :
> On Fri, 15 Dec 2006 15:45:08 +0100
> Nicolas FERRE <nicolas.ferre@rfo.atmel.com> wrote:
> 
>> Add support for the ads7843 touchscreen controller to the ads7846
>> driver code.
> 
> Generates a lot of errors when applied to the current mainline kernel. 
> Please prepare and test patches against Linus's current git tree.

Hi,

David Brownell told me to take into account code written by
the omap/N770 guys.
I will then refresh my patch against those bits and produce
an up-to-date patch.

Follow-up for this thread @
http://lkml.org/lkml/2006/12/20/293

Regards,
-- 
Nicolas Ferre


