Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261622AbVCCLfq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261622AbVCCLfq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 06:35:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261643AbVCCLfp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 06:35:45 -0500
Received: from a26.t1.student.liu.se ([130.236.221.26]:26854 "EHLO
	mail.drzeus.cx") by vger.kernel.org with ESMTP id S261622AbVCCLdW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 06:33:22 -0500
Message-ID: <4226F5FD.1050304@drzeus.cx>
Date: Thu, 03 Mar 2005 12:33:17 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041127)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: krishna <krishna.c@globaledgesoft.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: problem between audio driver and mmc driver
References: <4221E981.10004@globaledgesoft.com>
In-Reply-To: <4221E981.10004@globaledgesoft.com>
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

krishna wrote:
> Hi All,
> 
> I have a strange problem.
> The Audio driver is statically compiled into the kernel.
> 
> When I am loading my MMC driver, It is getting Audio Interrupts.
> 
> I browsed thru the web and found out it is a bug in the hardware.
> 
> The hardware bug is preventing Audio driver and MMC driver work 
> simultaneously.
> Does any one have a solution Or a Work around to make both the drivers 
> work though the audio driver
> is statically compiled into the kernel.
> 

You should specify which hardware (audio and mmc) that is causing the 
problem and also try to include the maintainers of each as cc.
Also, it's helpful if you can include links to the websites you've found 
concerning the problem.

Rgds
Pierre
