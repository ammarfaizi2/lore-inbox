Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751169AbVKHILV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751169AbVKHILV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 03:11:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751203AbVKHILV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 03:11:21 -0500
Received: from [85.8.13.51] ([85.8.13.51]:8344 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S1751169AbVKHILV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 03:11:21 -0500
Message-ID: <43705DA1.3090309@drzeus.cx>
Date: Tue, 08 Nov 2005 09:11:13 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mail/News 1.5 (X11/20051105)
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: [ANNOUNCE] Driver project for Secure Digital Host Controller Interface
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've started working on a driver for the Secure Digital Host Controller 
specification. This seems to be used by the majority of the controllers 
found in todays PCs, so this driver would add support for a lot of 
chips. Information is scarce so I do not know if this driver will get 
production ready, but for those of you willing to live dangerously:

http://mmc.drzeus.cx/wiki/Linux/Drivers/sdhci

Rgds
Pierre

