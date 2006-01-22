Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932245AbWAVR1z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932245AbWAVR1z (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jan 2006 12:27:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932276AbWAVR1z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jan 2006 12:27:55 -0500
Received: from [84.204.75.166] ([84.204.75.166]:37259 "EHLO
	shelob.oktetlabs.ru") by vger.kernel.org with ESMTP id S932245AbWAVR1y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jan 2006 12:27:54 -0500
Message-ID: <43D3C098.70808@yandex.ru>
Date: Sun, 22 Jan 2006 20:27:52 +0300
From: "Artem B. Bityutskiy" <dedekind@yandex.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050923 Fedora/1.7.12-1.5.1
X-Accept-Language: en, ru, en-us
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-mtd@lists.infradead.org,
       dwmw2@infradead.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC: 2.6 patch] MTD_NAND_SHARPSL and MTD_NAND_NANDSIM should
 be	tristate's
References: <20060122171256.GE10003@stusta.de>
In-Reply-To: <20060122171256.GE10003@stusta.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> - config MTD_NAND_NANDSIM
> - 	bool "Support for NAND Flash Simulator"
> - 	depends on MTD_NAND && MTD_PARTITIONS
Oh, thanks, long time supposed to be fixed.

-- 
Best Regards,
Artem B. Bityutskiy,
St.-Petersburg, Russia.
