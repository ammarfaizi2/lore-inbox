Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264929AbTK3P55 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Nov 2003 10:57:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264930AbTK3P55
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Nov 2003 10:57:57 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:18608 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264929AbTK3P54
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Nov 2003 10:57:56 -0500
Message-ID: <3FCA1371.9090600@pobox.com>
Date: Sun, 30 Nov 2003 10:57:37 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Fernando_Alencar_Mar=F3stica?= <famarost@unimep.br>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       RealTek Mailing List <realtek@scyld.com>,
       Djalma Fadel Junior <fadel@ferasoft.com.br>,
       Walter Gima <wgima@ferasoft.com.br>,
       Francois Romieu <romieu@fr.zoreil.com>
Subject: Re: [PATCH 2.6] RTL8169 Suspend and Resume Stuff
References: <1070203973.1216.6.camel@oxygenium>
In-Reply-To: <1070203973.1216.6.camel@oxygenium>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fernando Alencar Maróstica wrote:
> Hi Jeff,
> 
> Here's a short patch for the new Realtek RTL8169 PCI Gigabit Driver
> (drivers/net/r8169.c) in kernel. This patch add new PCI suspend
> and resume code.
> 
> The patch applies against 2.4.23 and 2.6.0-test11. I've tested the 
> compilation with 2.4.23.

Can you please coordinate with Francois Romieu, who is kind enough to do 
a massive update of r8169.c, merging both RealTek's changes and several 
bug fixes?

	Jeff



