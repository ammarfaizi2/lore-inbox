Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965158AbVLOGzB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965158AbVLOGzB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 01:55:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965160AbVLOGzB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 01:55:01 -0500
Received: from smtp104.sbc.mail.re2.yahoo.com ([68.142.229.101]:35500 "HELO
	smtp104.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S965158AbVLOGzA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 01:55:00 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Subject: Re: [patch 2/3] wbsd: run through Lindent
Date: Thu, 15 Dec 2005 01:54:57 -0500
User-Agent: KMail/1.8.3
Cc: wbsd-devel@list.drzeus.cx, linux-kernel@vger.kernel.org
References: <20051215053933.125918000.dtor_core@ameritech.net> <20051215054444.734214000.dtor_core@ameritech.net> <43A11297.7080303@drzeus.cx>
In-Reply-To: <43A11297.7080303@drzeus.cx>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512150154.57453.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 15 December 2005 01:52, Pierre Ossman wrote:
> Dmitry Torokhov wrote:
> 
> >wbsd: run through Lindent to ensure conding style compliance
> >
> >Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> >---
> >
> >  
> >
> 
> There is a patch for wbsd lingering in mm. lindenting the code will
> probably break it, so could you hold off on this until after it's
> merged? (probably post 2.6.15)
>

Sure, I am not attached to this patch ;) It is your call anyway. 

-- 
Dmitry
