Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261241AbVDGWVm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261241AbVDGWVm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 18:21:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262171AbVDGWVm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 18:21:42 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:53512 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261241AbVDGWVl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 18:21:41 -0400
Date: Fri, 8 Apr 2005 00:21:39 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Ben Castricum <benc@bencastricum.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc2 compile error in drivers/usb/class/cdc-acm.c
Message-ID: <20050407222139.GF4325@stusta.de>
References: <Pine.LNX.4.58.0504051026330.30674@gateway.bencastricum.nl> <20050406001807.GB7226@stusta.de> <Pine.LNX.4.58.0504061012420.31870@gateway.bencastricum.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0504061012420.31870@gateway.bencastricum.nl>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 06, 2005 at 10:22:50AM +0200, Ben Castricum wrote:
>...
> Just wondering, isn't 2.95.3 the recommended compiler anymore? I only use
> this (a bit old) version because it's _the_ compiler for the kernel.
>...

GNU gcc 2.95 is still a supported compiler (although the number of 
people using it seems to be steadily decreasing).

There's no clearly defined "recommended" compiler today.

cu
Adrian

--

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

