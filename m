Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261370AbVBHBQn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261370AbVBHBQn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 20:16:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261373AbVBHBQn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 20:16:43 -0500
Received: from smtp.andrew.cmu.edu ([128.2.10.83]:2786 "EHLO
	smtp.andrew.cmu.edu") by vger.kernel.org with ESMTP id S261370AbVBHBQl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 20:16:41 -0500
Message-ID: <420812E6.8040102@hackish.org>
Date: Mon, 07 Feb 2005 20:16:22 -0500
From: Peter Nelson <rufus-kernel@hackish.org>
User-Agent: Debian Thunderbird 1.0 (X11/20050118)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Eric Piel <Eric.Piel@tremplin-utc.net>
CC: vojtech@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hot-swapping support for PSX controllers
References: <42050EC2.3020402@tremplin-utc.net>
In-Reply-To: <42050EC2.3020402@tremplin-utc.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Piel wrote:

> Note that this is a re-send of a previous patch now that the patch of 
> Peter (which had to be applied before this one) has been intregrated 
> in the vanilla kernel. It's Peter's version modified to apply cleanly 
> against 2.6.11-rc3 plus a fix in the comment.

I was actually just about to re-post this patch.  I've tested it and it 
works for me, plus it saves a few bytes of kernel memory fixing the 
array sizes.

-Peter

> -- 
> Fixes hotplug support for PSX controllers and some mis-sized arrays.
>
> Signed-off-by: Eric Piel <eric.piel@tremplin-utc.net>
> Signed-off-by: Peter Nelson <rufus-kernel@hackish.org>

