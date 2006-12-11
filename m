Return-Path: <linux-kernel-owner+w=401wt.eu-S936352AbWLKOzU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936352AbWLKOzU (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 09:55:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936422AbWLKOzT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 09:55:19 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:46537 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S936372AbWLKOzN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 09:55:13 -0500
Message-ID: <457D714F.3010001@garzik.org>
Date: Mon, 11 Dec 2006 09:55:11 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Paul Mundt <lethal@linux-sh.org>, linux-kernel@vger.kernel.org,
       Russell King <rmk@arm.linux.org.uk>
Subject: Re: [PATCH] smc91x: Kill off excessive versatile hooks.
References: <20061211103006.GA32119@linux-sh.org>
In-Reply-To: <20061211103006.GA32119@linux-sh.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Mundt wrote:
> This looks like a result of too many auto-merges. The
> CONFIG_ARCH_VERSATILE case was handled a total of 6 times.
> This kills 5 of them.
> 
> Signed-off-by: Paul Mundt <lethal@linux-sh.org>

applied


