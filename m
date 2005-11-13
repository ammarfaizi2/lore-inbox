Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964932AbVKMQq7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964932AbVKMQq7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Nov 2005 11:46:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964934AbVKMQq7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Nov 2005 11:46:59 -0500
Received: from mail2.genealogia.fi ([194.100.116.229]:64220 "EHLO
	mail2.genealogia.fi") by vger.kernel.org with ESMTP id S964932AbVKMQq6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Nov 2005 11:46:58 -0500
Date: Sun, 13 Nov 2005 08:46:36 -0800
From: Jouni Malinen <jkmaline@cc.hut.fi>
To: Adrian Bunk <bunk@stusta.de>
Cc: hostap@shmoo.com, linux-kernel@vger.kernel.org, jgarzik@pobox.com,
       netdev@vger.kernel.org, sam@ravnborg.org
Subject: Re: [2.6 patch] rename hostap.c to hostap_main.c
Message-ID: <20051113164636.GB8968@jm.kir.nu>
Mail-Followup-To: Adrian Bunk <bunk@stusta.de>, hostap@shmoo.com,
	linux-kernel@vger.kernel.org, jgarzik@pobox.com,
	netdev@vger.kernel.org, sam@ravnborg.org
References: <20051106005343.GF3668@stusta.de> <20051106041543.GC8972@jm.kir.nu> <20051113162745.GM21448@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051113162745.GM21448@stusta.de>
User-Agent: Mutt/1.5.8i
X-Spam-Score: -2.6 (--)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 13, 2005 at 05:27:45PM +0100, Adrian Bunk wrote:

> There's no other change.
> 
> If you agree, Jeff might be able to do the
> 
>   mv drivers/net/wireless/hostap/hostap.c \
>     drivers/net/wireless/hostap/hostap_main.c
> 
> plus applying the patch below.

OK, I'm okay with that change.

-- 
Jouni Malinen                                            PGP id EFC895FA
