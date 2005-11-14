Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932123AbVKNUym@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932123AbVKNUym (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 15:54:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932124AbVKNUym
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 15:54:42 -0500
Received: from mail.dvmed.net ([216.237.124.58]:32928 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932123AbVKNUyl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 15:54:41 -0500
Message-ID: <4378F983.4070302@pobox.com>
Date: Mon, 14 Nov 2005 15:54:27 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ben Collins <bcollins@debian.org>
CC: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [RESEND PATCH 2.6.15-rc1] Update location of ll_rw_blk.c in kernel-api.tmpl
References: <20051114193502.GA15937@swissdisk.com>
In-Reply-To: <20051114193502.GA15937@swissdisk.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Collins wrote:
> Picked from the ubuntu-2.6 tree
> 
> diff-tree d96fe6eeebd11fb8f70d091eb368e901cec64e1b (from cfd55027d8596fdd19e0023573cc0a6b92994d35)
> Author: Ben Collins <bcollins@ubuntu.com>
> Date:   Sat Nov 12 09:29:51 2005 -0500
> 
>     [UBUNTU:Documentation] Update location of ll_rw_blk.c in docs
>     
>     The change in location for ll_rw_blk.c from drivers/block/ to block/
>     caused failure to generate documentation.
>     
>     UpstreamStatus: Submitted for 2.6.15
>     
>     Signed-off-by: Ben Collins <bcollins@ubuntu.com>

ACK


