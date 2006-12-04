Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937434AbWLDWi2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937434AbWLDWi2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 17:38:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937442AbWLDWi2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 17:38:28 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:38770 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S937434AbWLDWi1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 17:38:27 -0500
Message-ID: <4574A35E.60007@pobox.com>
Date: Mon, 04 Dec 2006 17:38:22 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Alan <alan@lxorguk.ukuu.org.uk>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
Subject: Re: [PATCH] pata_it8213: Add new driver for the IT8213 card.
References: <20061204164931.7d36d744@localhost.localdomain>	<20061204124344.a7c21221.akpm@osdl.org> <20061204215558.63bc4e90@localhost.localdomain>
In-Reply-To: <20061204215558.63bc4e90@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan wrote:
>> Was the duplication of timings[] deliberate?
> 
> It's actually duplicated in all the PIIX/ICH-alike drivers. I could move
> it in them all. Jeff - its copied from your piix driver - shall I move
> them all ?

Please do...

	Jeff



