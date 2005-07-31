Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261829AbVGaQs1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261829AbVGaQs1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 12:48:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261844AbVGaQs0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 12:48:26 -0400
Received: from mail.dvmed.net ([216.237.124.58]:16090 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261828AbVGaQqA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 12:46:00 -0400
Message-ID: <42ED003B.7070005@pobox.com>
Date: Sun, 31 Jul 2005 12:45:47 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Netdev List <netdev@vger.kernel.org>
Subject: Re: [git patches] new wireless stuffs
References: <42EC0C3E.7030705@pobox.com> <20050731110736.GA4020@infradead.org>
In-Reply-To: <20050731110736.GA4020@infradead.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> Any chance we can give the hostap driver a better name?  hostap describes
> the AP mode it can operate on, but it should really be named after the hardware
> it supports in some way.


If the driver gets rewritten, sure.  Otherwise, users are already 
familiar with the name.

	Jeff


