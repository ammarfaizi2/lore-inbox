Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751223AbWFWDcj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751223AbWFWDcj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 23:32:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751224AbWFWDcj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 23:32:39 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:43911 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751222AbWFWDci (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 23:32:38 -0400
Message-ID: <449B60C5.50709@pobox.com>
Date: Thu, 22 Jun 2006 23:32:21 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Herbert Xu <herbert@gondor.apana.org.au>, davem@davemloft.net,
       snakebyte@gmx.de, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: Memory corruption in 8390.c ?
References: <E1FtNNQ-0001QW-00@gondolin.me.apana.org.au> <1150982734.15275.166.camel@localhost.localdomain>
In-Reply-To: <1150982734.15275.166.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

applied except for orinoco, which failed to apply (rediff?)

