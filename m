Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268161AbUHTOl4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268161AbUHTOl4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 10:41:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268153AbUHTOlz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 10:41:55 -0400
Received: from the-village.bc.nu ([81.2.110.252]:61063 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S266890AbUHTOkz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 10:40:55 -0400
Subject: Re: [PATCH] dothan speedstep fix
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Con Kolivas <kernel@kolivas.org>
Cc: jeremy@goop.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <4125A036.8020401@kolivas.org>
References: <4125A036.8020401@kolivas.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1093009108.30968.43.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 20 Aug 2004 14:38:28 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2004-08-20 at 07:54, Con Kolivas wrote:
> Hi Jeremy
> 
> My new dothan cpu comes up as stepping 6. This patch fixes speedstep 
> support for my laptop unless it can come up as multiple stepping values? 
> Now all I need is for a way to make it report the correct L2 cache.

The patch I posted to l/k a few minutea ago should fix the L2 cache
reporting. 
