Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262342AbTIUFhE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Sep 2003 01:37:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262343AbTIUFhE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Sep 2003 01:37:04 -0400
Received: from mail.g-housing.de ([62.75.136.201]:23271 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S262342AbTIUFhC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Sep 2003 01:37:02 -0400
Message-ID: <3F6D38FC.2020408@g-house.de>
Date: Sun, 21 Sep 2003 07:37:00 +0200
From: Christian <evil@g-house.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.5b) Gecko/20030917
X-Accept-Language: de-de, de, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: lockups with 2.4.2x
References: <3F6D134E.2080505@g-house.de>
In-Reply-To: <3F6D134E.2080505@g-house.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some updates from me:

evil aka Christian wrote:
> http://nerdbynature.de/bits/freeze/config|cpuinfo|dmesg|lspci
> 
> (directory listing follows...)

now it's all here: http://www.nerdbynature.de/bits/

> before this whole mess i was using 2.4.19, but i wanted to upgrade to
> 2.4.20, 2.4.21, did not make it, due to lack of time or need. 2.4.19 was
> running fine. but i need netfilter now, so i had to recompile
> modules+kernel!  but, mysteriously, i fail to recompile my 2.4.19. i did

i was able to recompile 2.4.19, but i had to use gcc-2.95.4 (from 
debian/testing.) Kernel boots fine, even loads my 3rd party module
(ISDN/CAPI related, taints the kernel), no freezes. i have compiled 
2.4.22 with gcc2.95 too, but it's still freezing.

Thanks,
Christian.
-- 
BOFH excuse #201:

RPC_PMAP_FAILURE


