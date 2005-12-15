Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750705AbVLOObI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750705AbVLOObI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 09:31:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750707AbVLOObI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 09:31:08 -0500
Received: from relay4.usu.ru ([194.226.235.39]:23684 "EHLO relay4.usu.ru")
	by vger.kernel.org with ESMTP id S1750705AbVLOObG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 09:31:06 -0500
Message-ID: <43A17DFF.8020804@ums.usu.ru>
Date: Thu, 15 Dec 2005 19:30:23 +0500
From: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
User-Agent: Debian Thunderbird 1.0.2 (X11/20051002)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.15-rc5-mm3
References: <20051214234016.0112a86e.akpm@osdl.org>
In-Reply-To: <20051214234016.0112a86e.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by AntiVir MailGate (version: 2.0.1.15; AVE: 6.33.0.11; VDF: 6.33.0.29; host: usu2.usu.ru)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.15-rc5/2.6.15-rc5-mm3/
> - I'm not aware of any of the more serious bugs in rc5-mm1 and rc5-mm2
>   being fixed.  If anyone finds that there's a previously-reported problem
>   in here then please just re-report it and don't be afraid to spread the
>   Cc's around.

The bug with ppp packets autoreplicating and dead keyboard is still 
there. Be sure to load CPU and disk for faster reproduction of the bug. 
Original report: http://lkml.org/lkml/2005/11/7/147

-- 
Alexander E. Patrakov

