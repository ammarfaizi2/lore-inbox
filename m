Return-Path: <linux-kernel-owner+w=401wt.eu-S1757938AbWLKVH7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757938AbWLKVH7 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 16:07:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758687AbWLKVH7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 16:07:59 -0500
Received: from smtp2-g19.free.fr ([212.27.42.28]:55868 "EHLO smtp2-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757938AbWLKVH6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 16:07:58 -0500
Message-ID: <457DC8E4.2050102@free.fr>
Date: Mon, 11 Dec 2006 22:08:52 +0100
From: Thierry MERLE <thierry.merle@free.fr>
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: mchehab@infradead.org, v4l-dvb-maintainer@linuxtv.org,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] usbvision: possible cleanups
References: <20061211184059.GD28443@stusta.de>
In-Reply-To: <20061211184059.GD28443@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Right.
This is not a surprise, the driver still works flawlessly.
Thanks

Regards,
Thierry

Adrian Bunk a écrit :
> This patch contains the following possible cleanups:
> - make needlessly global functions static
> - remove the unused EXPORT_SYMBOL's
>
>   
