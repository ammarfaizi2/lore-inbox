Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261752AbVADRuX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261752AbVADRuX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 12:50:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261793AbVADRuX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 12:50:23 -0500
Received: from quechua.inka.de ([193.197.184.2]:61336 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S261752AbVADRuO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 12:50:14 -0500
From: Bernd Eckenfels <ecki-news2004-12@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Let me know EIP address
Organization: Deban GNU/Linux Homesite
In-Reply-To: <20050104171043.21c7c4ef@tux.homenet>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.6-20040906 ("Baleshare") (UNIX) (Linux/2.6.8.1 (i686))
Message-Id: <E1Clsot-0002EU-00@calista.eckenfels.6bone.ka-ip.net>
Date: Tue, 04 Jan 2005 18:50:11 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20050104171043.21c7c4ef@tux.homenet> you wrote:
>> I'm trying to get the EIP value from a simple program in C but i don't

> The EIP register cannot be accessed directly by software

I guess most often is enough to get the address of a C function

printf("%p", &func);

Greetings
Bernd
