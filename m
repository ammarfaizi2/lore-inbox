Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130588AbRCMEEQ>; Mon, 12 Mar 2001 23:04:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130661AbRCMEEG>; Mon, 12 Mar 2001 23:04:06 -0500
Received: from vp175062.reshsg.uci.edu ([128.195.175.62]:5390 "EHLO
	moisil.dev.hydraweb.com") by vger.kernel.org with ESMTP
	id <S130588AbRCMEDx>; Mon, 12 Mar 2001 23:03:53 -0500
Date: Mon, 12 Mar 2001 20:03:20 -0800
Message-Id: <200103130403.f2D43Kh10666@moisil.dev.hydraweb.com>
From: Ion Badulescu <ionut@moisil.cs.columbia.edu>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Linux Knernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Modular versus non-modular ISAPNP
In-Reply-To: <3AAD8DB4.9DAC348C@mandrakesoft.com>
User-Agent: tin/1.5.7-20001104 ("Paradise Regained") (UNIX) (Linux/2.2.18 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Mar 2001 22:02:12 -0500, Jeff Garzik <jgarzik@mandrakesoft.com> wrote:

> It is highly recommended to always compile with CONFIG_ISAPNP=y due to
> these differences.  If you grep around for CONFIG_ISAPNP versus
> CONFIG_ISAPNP_MODULE, you'll see that many drivers are woefully
> unprepared for isapnp support compiled as a module.

Another entry for the Kernel Janitor's List, perhaps?

Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.
