Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261173AbULWHlJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261173AbULWHlJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Dec 2004 02:41:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261174AbULWHlJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Dec 2004 02:41:09 -0500
Received: from smtp-vbr12.xs4all.nl ([194.109.24.32]:45579 "EHLO
	smtp-vbr12.xs4all.nl") by vger.kernel.org with ESMTP
	id S261173AbULWHlG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Dec 2004 02:41:06 -0500
Date: Thu, 23 Dec 2004 08:41:05 +0100 (CET)
From: Erik Oomen <erik.oomen@ctc.nl>
X-X-Sender: ooer@merlot
To: linux-kernel@vger.kernel.org
Subject: Re: kswapd cpu-eating FIXED by Andrew's patch!
In-Reply-To: <3eflN-5Dx-23@gated-at.bofh.it>
Message-ID: <Pine.LNX.4.58.0412230839220.7232@merlot>
References: <3eflN-5Dx-23@gated-at.bofh.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Dec 2004, Mikhail Ramendik wrote:

> On another matter, Andrew Morton posted this patch:
>
> http://marc.theaimsgroup.com/?l=linux-kernel&m=110357628419245&w=2
>
> Rik hinted that it could be the cause of the CPU eating problem. I have
> applied it (to 2.6.10-rc3 with token-disable and vm-throttling already
> applied), and - BINGO! No noticeable kswapd CPU load at all!

I can confirm this, fixed my kswapd CPU load as well.

Erik.

