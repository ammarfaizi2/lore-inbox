Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965157AbVLOGwL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965157AbVLOGwL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 01:52:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965159AbVLOGwL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 01:52:11 -0500
Received: from [85.8.13.51] ([85.8.13.51]:8883 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S965157AbVLOGwK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 01:52:10 -0500
Message-ID: <43A11297.7080303@drzeus.cx>
Date: Thu, 15 Dec 2005 07:52:07 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 1.0.7-2.1.fc4.nr (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dmitry Torokhov <dtor_core@ameritech.net>
CC: wbsd-devel@list.drzeus.cx, linux-kernel@vger.kernel.org
Subject: Re: [patch 2/3] wbsd: run through Lindent
References: <20051215053933.125918000.dtor_core@ameritech.net> <20051215054444.734214000.dtor_core@ameritech.net>
In-Reply-To: <20051215054444.734214000.dtor_core@ameritech.net>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov wrote:

>wbsd: run through Lindent to ensure conding style compliance
>
>Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
>---
>
>  
>

There is a patch for wbsd lingering in mm. lindenting the code will
probably break it, so could you hold off on this until after it's
merged? (probably post 2.6.15)

Rgds
Pierre

