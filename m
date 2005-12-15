Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750707AbVLOQKA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750707AbVLOQKA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 11:10:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750776AbVLOQKA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 11:10:00 -0500
Received: from [85.8.13.51] ([85.8.13.51]:7860 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S1750707AbVLOQJ7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 11:09:59 -0500
Message-ID: <43A19557.1070605@drzeus.cx>
Date: Thu, 15 Dec 2005 17:09:59 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mail/News 1.5 (X11/20051129)
MIME-Version: 1.0
To: Dmitry Torokhov <dtor_core@ameritech.net>
CC: wbsd-devel@list.drzeus.cx, linux-kernel@vger.kernel.org,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [patch 3/3] wbsd: make use of ARRAY_SIZE() macro
References: <20051215053933.125918000.dtor_core@ameritech.net> <20051215054444.854564000.dtor_core@ameritech.net>
In-Reply-To: <20051215054444.854564000.dtor_core@ameritech.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov wrote:
> wbsd: make use of ARRAY_SIZE() macro
>
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> ---
>
>   

Acked-by: Pierre Ossman <drzeus@drzeus.cx>

(Provided it's fixed to come before the lindent patch.)

