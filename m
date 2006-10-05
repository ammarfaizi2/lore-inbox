Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750964AbWJET04@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750964AbWJET04 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 15:26:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750981AbWJET04
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 15:26:56 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:5505 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750936AbWJET0y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 15:26:54 -0400
Message-ID: <45255C7D.20309@garzik.org>
Date: Thu, 05 Oct 2006 15:26:53 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: misha@fabric7.com
CC: KERNEL Linux <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/10] VIOC: New Network Device Driver
References: <200610051045.35760.misha@fabric7.com>
In-Reply-To: <200610051045.35760.misha@fabric7.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Misha Tomushev wrote:
> The following patch series introduces the VIOC Device Driver, that
> provides a network device inerface
> to the internal fabric interconnected network used on servers designed and
> built by Fabric 7 Systems.

Please make this available somewhere as a single patch file.  It's 
easier to review, and we never merge new drivers as a series of patches.

(granted, you need to split it up to get around the mailing list's 100K 
size limit)

