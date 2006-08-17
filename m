Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932202AbWHQMQS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932202AbWHQMQS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 08:16:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932211AbWHQMQS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 08:16:18 -0400
Received: from vsmtp21alice.tin.it ([212.216.176.110]:45197 "EHLO
	vsmtp21.tin.it") by vger.kernel.org with ESMTP id S932202AbWHQMQR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 08:16:17 -0400
Message-ID: <3174.192.167.206.189.1155816974.squirrel@new.host.name>
In-Reply-To: <6753EB6004AFF34FAA275742C104F95201753B@wacom-nt10.wacom.com>
References: <6753EB6004AFF34FAA275742C104F95201753B@wacom-nt10.wacom.com>
Date: Thu, 17 Aug 2006 14:16:14 +0200 (CEST)
Subject: Re: Removing of UTS_RELEASE in include/linux/version.h
From: "Luigi Genoni" <genoni@sns.it>
To: "Ping Cheng" <pingc@wacom.com>
Cc: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

use linux/utsrelease.h

On Thu, August 17, 2006 02:46, Ping Cheng wrote:
> Hi Sam,
>
>
> I was told that the removing of UTS_RELEASE in include/linux/version.h is
> permanent. I use it in my configuration script to get the version numbers
> of different kernel build sources.  Greg k-h told me to ask you about how
> to properly get the kernel source version.  Do you have any suggestions?
> Please don't forget to cc me directly since I am not in the mailing list.
>
>
> Thanks,
>
>
> Ping
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>  the body of a message to majordomo@vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
>


