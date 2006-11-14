Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966018AbWKNPlT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966018AbWKNPlT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 10:41:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966028AbWKNPlT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 10:41:19 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:43968 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S966018AbWKNPlS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 10:41:18 -0500
Message-ID: <4559E39A.1040009@garzik.org>
Date: Tue, 14 Nov 2006 10:41:14 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Krzysztof Halasa <khc@pm.waw.pl>
CC: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       Francois Romieu <romieu@cogenit.fr>
Subject: Re: [PATCH] WAN: DSCC4 driver requires generic HDLC
References: <m37ixz89nt.fsf@defiant.localdomain>
In-Reply-To: <m37ixz89nt.fsf@defiant.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Krzysztof Halasa wrote:
> Another thing, reported recently to me by several people - DSCC4 WAN
> driver now (and perhaps for the last couple of years+) requires the
> generic HDLC. I've fixed the Kconfig and moved the DSCC4 option
> under CONFIG_HDLC so it's consistent visually.
> 
> Jeff, Francois, I think it's safe to apply. Thanks.
> 
> Signed-off-by: Krzysztof Halasa <khc@pm.waw.pl>

applied


