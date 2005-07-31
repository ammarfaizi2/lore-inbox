Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261767AbVGaNk0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261767AbVGaNk0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 09:40:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261765AbVGaNi7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 09:38:59 -0400
Received: from anchor-post-35.mail.demon.net ([194.217.242.85]:50187 "EHLO
	anchor-post-35.mail.demon.net") by vger.kernel.org with ESMTP
	id S261778AbVGaNik (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 09:38:40 -0400
Message-ID: <42ECD45A.50803@superbug.demon.co.uk>
Date: Sun, 31 Jul 2005 14:38:34 +0100
From: James Courtier-Dutton <James@superbug.demon.co.uk>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050729)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: linux-kernel@vger.kernel.org, perex@suse.cz, alsa-devel@alsa-project.org,
       sailer@ife.ee.ethz.ch, linux-sound@vger.kernel.org, zab@zabbo.net,
       kyle@parisc-linux.org, parisc-linux@lists.parisc-linux.org,
       jgarzik@pobox.com, Thorsten Knabe <linux@thorsten-knabe.de>,
       zwane@commfireservices.com, zaitcev@yahoo.com
Subject: Re: [2.6 patch] schedule obsolete OSS drivers for removal
References: <20050726150837.GT3160@stusta.de>
In-Reply-To: <20050726150837.GT3160@stusta.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> This patch schedules obsolete OSS drivers (with ALSA drivers that 
> support the same hardware) for removal.
> 
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> ---
> 
> I've Cc'ed the people listed in MAINTAINERS as being responsible for one 
> or more of these drivers, and I've also Cc'ed the ALSA people.
> 

I am happy for the emu10k1 OSS driver to go.
The ALSA driver has considerably more features now.

James
