Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266175AbUIAMLe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266175AbUIAMLe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 08:11:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266217AbUIAMLe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 08:11:34 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:26067 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S266175AbUIAMLa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 08:11:30 -0400
Date: Wed, 1 Sep 2004 08:15:55 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Romain Moyne <aero_climb@yahoo.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Time runs exactly three times too fast
In-Reply-To: <200409021453.09730.aero_climb@yahoo.fr>
Message-ID: <Pine.LNX.4.58.0409010814580.4481@montezuma.fsmlabs.com>
References: <200409021453.09730.aero_climb@yahoo.fr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Sep 2004, Romain Moyne wrote:

> Hello, I'm french, sorry for my bad english :(
>
> I have a problem with my kernel: Time runs exactly three times too fast.
>
> I tested the kernel 2.6.8.1 and the 2.6.9-rc1, no success.
> It is really strange because yesterday I reinstalled my debian with a kernel
> 2.6.8.1 (made by me): Time ran correctly. And this morning when I rebooted my
> computer (Compaq presario R3000 series, R3215EA exactly) the time is running
> again three times too fast (with the kernel 2.6.8.1 and 2.6.9-rc1).
>
> All my applications (KDE, command "date"...) runs three times too fast. It's
> very annoying.

Can you try this without cpuspeed or some frequency control daemon
running? So disable it in runlevel scripts and then reboot.

