Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262829AbTHURGi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 13:06:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262828AbTHURGW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 13:06:22 -0400
Received: from natsmtp01.webmailer.de ([192.67.198.81]:10656 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP id S262806AbTHURFs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 13:05:48 -0400
Message-ID: <3F449674.2040102@softhome.net>
Date: Thu, 21 Aug 2003 11:52:52 +0200
From: "Ihar 'Philips' Filipau" <filia@softhome.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030701
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Takao Indoh <indou.takao@soft.fujitsu.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: cache limit
References: <m6Bv.3ys.1@gated-at.bofh.it> <mLY8.dO.5@gated-at.bofh.it>
In-Reply-To: <mLY8.dO.5@gated-at.bofh.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Takao Indoh wrote:
> 
> I made a patch to add new paramter /proc/sys/vm/pgcache-max. It controls
> maximum number of pages used as pagecache.
> An attached file is a mere test patch, so it may contain a bug or ugly
> code. Please let me know if there is an advice, comment, better
> implementation, and so on.
> 

   Do you have something like this for 2.4 kernels?

   [ I expected to find that by default Linux stops polluting memory 
with cache when there is no more pages. But as I see your patch is 
hacking something somewhere in the middle... But I'm not a specialist in 
VM... Gone reading sources. ]

   Thanks for the patch.

