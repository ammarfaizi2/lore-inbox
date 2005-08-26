Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030226AbVHZTdQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030226AbVHZTdQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 15:33:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030225AbVHZTdQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 15:33:16 -0400
Received: from mail.dvmed.net ([216.237.124.58]:20651 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030226AbVHZTdO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 15:33:14 -0400
Message-ID: <430F6E6F.5010001@pobox.com>
Date: Fri, 26 Aug 2005 15:33:03 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Robert Love <rml@novell.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Arjan van de Ven <arjan@infradead.org>,
       Brian Gerst <bgerst@didntduck.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] IBM HDAPS accelerometer driver.
References: <1125069494.18155.27.camel@betsy>	 <430F5257.4010700@didntduck.org>  <1125077594.18155.52.camel@betsy>	 <1125079311.4294.10.camel@laptopd505.fenrus.org>	 <1125079430.18155.64.camel@betsy>	 <1125086134.14080.13.camel@localhost.localdomain> <1125084555.18155.89.camel@betsy>
In-Reply-To: <1125084555.18155.89.camel@betsy>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love wrote:
> On Fri, 2005-08-26 at 20:55 +0100, Alan Cox wrote:
> 
> 
>>I think that should be fixed before its merged.
> 
> 
> Let me be clear, it has an init routine that effectively probes for the
> device.
> 
> It just lacks a simple quick non-invasive check.

Since such a check is possible, that's definitely a merge-stopper IMO

	Jeff



