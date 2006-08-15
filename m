Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030282AbWHONcR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030282AbWHONcR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 09:32:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030285AbWHONcR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 09:32:17 -0400
Received: from mailgate.cesmail.net ([216.154.195.36]:64661 "HELO
	mailgate.cesmail.net") by vger.kernel.org with SMTP
	id S1030282AbWHONcR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 09:32:17 -0400
Message-ID: <20060815093215.ckw4s4g8owok0oss@webmail.spamcop.net>
Date: Tue, 15 Aug 2006 09:32:15 -0400
From: Pavel Roskin <proski@gnu.org>
To: Henne <henne@nachtwindheim.de>
Cc: orinoco-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [NETDEV] [ORINOCO] pci_module_init() ->
	pci_register_driver()
References: <44E1C624.4010607@nachtwindheim.de>
In-Reply-To: <44E1C624.4010607@nachtwindheim.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
User-Agent: Internet Messaging Program (IMP) 4.0-cvs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Henne <henne@nachtwindheim.de>:

> From: Henrik Kretzschmar <henne@nachtwindheim.de>
>
> Change pci_module_init() to pci_register_driver().
> This pci_module_init() came to the kernel after 2.6.17.

I have already submitted a patch for this, first for all drivers in the kernel,
and then for all drivers under drivers/net.

--
Regards,
Pavel Roskin
