Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262129AbTIRUxH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Sep 2003 16:53:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262130AbTIRUxH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Sep 2003 16:53:07 -0400
Received: from MAIL.13thfloor.at ([212.16.62.51]:44752 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S262129AbTIRUxD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Sep 2003 16:53:03 -0400
Date: Thu, 18 Sep 2003 22:53:02 +0200
From: Herbert Poetzl <herbert@13thfloor.at>
To: Bernhard Rosenkraenzer <bero@arklinux.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.23-pre4-pac1 ALSA+preemptible kernel
Message-ID: <20030918205301.GA1290@DUK2.13thfloor.at>
Mail-Followup-To: Bernhard Rosenkraenzer <bero@arklinux.org>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.56.0309152354580.20178@dot.kde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.56.0309152354580.20178@dot.kde.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 15, 2003 at 11:59:37PM +0200, Bernhard Rosenkraenzer wrote:
> I've ported some popular patches to the -pac branch [they are not 
> currently in -pac, and I have no immediate plans to add them directly to 
> -pac]:
> 
> preempt-kernel-2.4.23-pre4-pac1 -- preemptible kernel patch
> alsa-0.9.6-2.4.23 -- patch for ALSA 0.9.6 drivers to build [and work] with
>                      2.4.23-pre4-pac1

do you have any preempt patches for vanilla 2.4.23-pre4,
or do you know where I could get them?

TIA,
Herbert

> both can be found in
> 
> /pub/linux/kernel/people/bero/2.4/extra/
> 
> on your favourite kernel.org mirror.
> 
> LLaP
> bero
> 
> -- 
> Ark Linux - Linux for the masses
> http://www.arklinux.org/
> 
> Redistribution and processing of this message is subject to
> http://www.arklinux.org/terms.php
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
