Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265367AbUAGImF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 03:42:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265394AbUAGImF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 03:42:05 -0500
Received: from cibs9.sns.it ([192.167.206.29]:35338 "EHLO cibs9.sns.it")
	by vger.kernel.org with ESMTP id S265367AbUAGImD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 03:42:03 -0500
Date: Wed, 7 Jan 2004 09:41:17 +0100 (CET)
From: venom@sns.it
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: LVM 2.6 compatibility?
In-Reply-To: <1073397568.29659.178.camel@roy-sin>
Message-ID: <Pine.LNX.4.43.0401070941040.23681-100000@cibs9.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


yes, there is full back compatibility

On Tue, 6 Jan 2004, Roy Sigurd Karlsbakk wrote:

> Date: Tue, 06 Jan 2004 14:59:28 +0100
> From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
> To: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
> Subject: LVM 2.6 compatibility?
>
> hi all
>
> I have this archive server running 2.4 and LVM across two 3ware hardware
> RAID-5 sets with 8 drives each. Now, upgrading the server, I want a new
> logical volume >2TB so I need 2.6. But - one of the logical volumes
> would be very nice to keep. Can I upgrade to 2.6 and keep the old LV?
>
> roy
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

