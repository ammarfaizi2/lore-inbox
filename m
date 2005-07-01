Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261418AbVGALuB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261418AbVGALuB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 07:50:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263310AbVGALuB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 07:50:01 -0400
Received: from [195.23.16.24] ([195.23.16.24]:53958 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S261418AbVGALt5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 07:49:57 -0400
Message-ID: <42C52DDB.60309@grupopie.com>
Date: Fri, 01 Jul 2005 12:49:47 +0100
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: raja <vnagaraju@effigent.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: network device drivers
References: <opss8fppx3clt1sm@nagaraju.effigent.net>
In-Reply-To: <opss8fppx3clt1sm@nagaraju.effigent.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

raja wrote:
> Will you please suggest the books for implementing rt8139 ethernet driver

This driver has been in the kernel for ages (check drivers/net/8139too.c).

Why would you want to implement another one?

Anyway, a good book on writing device drivers:

Linux Device Drivers 3rd Edition, O'Reilly - ISBN: 0596005903

-- 
Paulo Marques - www.grupopie.com

It is a mistake to think you can solve any major problems
just with potatoes.
Douglas Adams
