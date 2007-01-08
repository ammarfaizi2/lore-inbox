Return-Path: <linux-kernel-owner+w=401wt.eu-S1161336AbXAHQQz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161336AbXAHQQz (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 11:16:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161337AbXAHQQz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 11:16:55 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:55509 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161336AbXAHQQz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 11:16:55 -0500
Message-ID: <45A26E74.2050509@pobox.com>
Date: Mon, 08 Jan 2007 11:16:52 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: Alan <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] extract duplicated constants out of PIIX like drivers
References: <20070108122313.73c08d2e@localhost.localdomain>
In-Reply-To: <20070108122313.73c08d2e@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan wrote:
> Each PIIX driver has two copies of a tiny 10 byte table. Jeff asked that
> it was moved to a common place in each driver. Personally I think it
> looked a lot better before but as Jeff is maintainer it's his call.
> 
> Signed-off-by: Alan Cox <alan@redhat.com>

Did I really ask for this?  ;-)

Looking at the patch, I think prefer the unpatched code, and would 
prefer to drop this patch if that's ok?

	Jeff



