Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266505AbUHCOkc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266505AbUHCOkc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 10:40:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266491AbUHCOkb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 10:40:31 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:50445 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S266505AbUHCOk3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 10:40:29 -0400
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: dlion <dlion2005@yahoo.com.cn>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: Realtek 8169 NIC driver version
Date: Tue, 3 Aug 2004 17:39:53 +0300
X-Mailer: KMail [version 1.4]
References: <1677288031.20040803142517@yahoo.com.cn>
In-Reply-To: <1677288031.20040803142517@yahoo.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200408031739.53477.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 03 August 2004 09:25, dlion wrote:
> Hello lkml,
>
>   I have read some driver codes in the Linux kernel. I noticed
> that the RTL-8169 driver(r8169.c) is an older version (v1.2).
> There is a newer drivers on Realtek's website. It's version
> number is v1.6 , and it is really much better than v1.2. Why
> not merge it into official kernel realease?

Make diff and send it (and your success story) to Jeff.
-- 
vda
