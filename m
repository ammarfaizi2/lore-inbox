Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261245AbVABJIl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261245AbVABJIl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jan 2005 04:08:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261246AbVABJIl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jan 2005 04:08:41 -0500
Received: from fyrebird.net ([217.70.144.192]:12416 "HELO fyrebird.net")
	by vger.kernel.org with SMTP id S261245AbVABJIh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jan 2005 04:08:37 -0500
X-Qmail-Scanner-Mail-From: lethalman@fyrebird.net via fyrebird
X-Qmail-Scanner: 1.23 (Clear:RC:0(62.11.82.106):. Processed in 1.712159 secs)
Message-ID: <41D7B745.1020705@fyrebird.net>
Date: Sun, 02 Jan 2005 09:56:37 +0100
From: Lethalman <lethalman@fyrebird.net>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] /proc/sys/kernel/bootloader_type
References: <41D34E3A.3090708@zytor.com> <loom.20050101T211932-0@post.gmane.org>
In-Reply-To: <loom.20050101T211932-0@post.gmane.org>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kay Sievers wrote:
> H. Peter Anvin <hpa <at> zytor.com> writes:
> 
> 
>>This patch exports to userspace the boot loader ID which has been 
>>exported by (b)zImage boot loaders since boot protocol version 2.
> 
> 
> Isn't /sys/kernel/bootloader_type a better place than /proc for new values?
> 
> Thanks,
> Kay
> 

In fact it's stored in /proc/sys/kernel/bootloader_type as sysctl does...
