Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161100AbWF0PN2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161100AbWF0PN2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 11:13:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161103AbWF0PN2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 11:13:28 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:6534 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1161098AbWF0PN0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 11:13:26 -0400
Message-ID: <44A14B14.6070900@garzik.org>
Date: Tue, 27 Jun 2006 11:13:24 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Jiri Slaby <jirislaby@gmail.com>
CC: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] use dev_printk() in some net drivers
References: <20060627145145.GA30053@havoc.gtf.org> <44A14A5F.3090607@gmail.com>
In-Reply-To: <44A14A5F.3090607@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jiri Slaby wrote:
> Don't you consider to use s#dev_printk(KERN_ERR, #dev_err(# macro?

Why, yes.  I had forgotten about those, thanks.

	Jeff


