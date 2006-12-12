Return-Path: <linux-kernel-owner+w=401wt.eu-S1751321AbWLLNJP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751321AbWLLNJP (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 08:09:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751320AbWLLNJO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 08:09:14 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:55314 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751235AbWLLNJN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 08:09:13 -0500
Message-ID: <457EA9F7.6090204@garzik.org>
Date: Tue, 12 Dec 2006 08:09:11 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Josh Boyer <jwboyer@gmail.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, jffs-dev@axis.com,
       David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH/RFC] Delete JFFS (version 1)
References: <457EA2FE.3050206@garzik.org> <625fc13d0612120456p1d74663fp21e40ee84a8819bc@mail.gmail.com> <457EA86B.5010407@garzik.org>
In-Reply-To: <457EA86B.5010407@garzik.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> When it's more likely to get struck by lightning than encounter 
> filesystem X on a random hard drive in the field, filesystem X need not 
> be in the kernel.

As people are already poking me:)  I course meant "flash device" not 
"hard drive".

SATA maintainer's curse, I suppose, to think of all storage devices as 
hard drives, no matter how incorrect that might be :)

	Jeff


