Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263203AbSJCIXQ>; Thu, 3 Oct 2002 04:23:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263204AbSJCIXQ>; Thu, 3 Oct 2002 04:23:16 -0400
Received: from gaea.projecticarus.com ([195.10.228.71]:19864 "EHLO
	gaea.projecticarus.com") by vger.kernel.org with ESMTP
	id <S263203AbSJCIXO>; Thu, 3 Oct 2002 04:23:14 -0400
Message-ID: <3D9BFFAF.5070401@walrond.org>
Date: Thu, 03 Oct 2002 09:28:31 +0100
From: Andrew Walrond <andrew@walrond.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020831
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bryan Hundven <bryanh@nventure.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: SMP: errors.
References: <3D9B85A8.4050803@nventure.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get the same "bad: scheduling while atomic!" error with an asus PR-DLS 
dual xeon m/b

Bryan Hundven wrote:

> The dmesg for my kernel is attached, which should explain it all.
>
> The errors that I am concerned about are:
>    bad: scheduling while atomic!
> and...
>    Debug: sleeping function called from illegal context at slab.c:1374



