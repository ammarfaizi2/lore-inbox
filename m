Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262553AbVGMKHu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262553AbVGMKHu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 06:07:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262527AbVGMKHo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 06:07:44 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:12226 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S262545AbVGMKGq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 06:06:46 -0400
Date: Wed, 13 Jul 2005 12:06:42 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Talal jaafar <talal.jaafar@gmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: SSH/RSH Support for 2.6.12-2
In-Reply-To: <cd9967e205071222456d542c39@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0507131206090.14635@yvahk01.tjqt.qr>
References: <cd9967e205071222456d542c39@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>However, I keep getting "Permission Denied", and
>from the /var/log/message  it seems that the kernel has some security
>enabled that prevents outside communications.  Any help in regard to
>this issue would be appreciated?

Check the OUTPUT chain of your firewall, maybe.


Cheers,
Jan Engelhardt
-- 

