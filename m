Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261364AbUKNWr7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261364AbUKNWr7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 17:47:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261367AbUKNWr6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 17:47:58 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:8161 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261365AbUKNWrs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 17:47:48 -0500
Subject: Re: [2.6 patch] OSS via82cxxx_audio.c: enable procfs code
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Adrian Bunk <bunk@stusta.de>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041114022446.GK2249@stusta.de>
References: <20041114022446.GK2249@stusta.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1100468548.25615.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 14 Nov 2004 21:42:29 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2004-11-14 at 02:24, Adrian Bunk wrote:
> The patch below enables the procfs code in sound/oss/via82cxxx_audio.c 
> if CONFIG_PROC_FS=y.

I don't see what needs fixing here. Generally the /proc file shouldnt
exist

