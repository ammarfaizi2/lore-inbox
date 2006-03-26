Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932074AbWCZNzV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932074AbWCZNzV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 08:55:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932075AbWCZNzV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 08:55:21 -0500
Received: from [84.204.75.166] ([84.204.75.166]:31112 "EHLO
	shelob.oktetlabs.ru") by vger.kernel.org with ESMTP id S932074AbWCZNzV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 08:55:21 -0500
Message-ID: <44269D47.3010703@yandex.ru>
Date: Sun, 26 Mar 2006 17:55:19 +0400
From: "Artem B. Bityutskiy" <dedekind@yandex.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050923 Fedora/1.7.12-1.5.1
X-Accept-Language: en, ru, en-us
MIME-Version: 1.0
To: linux@horizon.com
Cc: kalin@thinrope.net, linux-kernel@vger.kernel.org
Subject: Re: Lifetime of flash memory
References: <20060323074929.26749.qmail@science.horizon.com>
In-Reply-To: <20060323074929.26749.qmail@science.horizon.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux@horizon.com wrote:
> On startup, the first thing a thumb drive or CompactFlash card does is
> read the extra 16 bytes from every sector and build a translation map,
> so when a request for a given logical sector comes in, it knows where
> to find it.  Note that there are more sectors on the ROM than on the
> hard drive it emulates, so there's always some spare space.
Hello,

some time ago I tried to find any documentation about CF internals, but 
failed. It seems like you may hint me where to find it, may you?

-- 
Best Regards,
Artem B. Bityutskiy,
St.-Petersburg, Russia.
