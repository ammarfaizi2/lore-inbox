Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274882AbTHPQiY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Aug 2003 12:38:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274880AbTHPQhR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Aug 2003 12:37:17 -0400
Received: from mail.kroah.org ([65.200.24.183]:12711 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S274871AbTHPQhN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Aug 2003 12:37:13 -0400
Date: Sat, 16 Aug 2003 09:36:44 -0700
From: Greg KH <greg@kroah.com>
To: walt <wa1ter@myrealbox.com>, ambx1@neo.rr.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test3 current - firewire compile error
Message-ID: <20030816163643.GB9735@kroah.com>
References: <3F3E288B.3010105@cornell.edu> <3F3DD93E.7090706@myrealbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F3DD93E.7090706@myrealbox.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 16, 2003 at 12:11:58AM -0700, walt wrote:
> Ivan Gyurdiev wrote:
> >Hopefully, this is not a duplicate post:
> >===========================================
> >
> >drivers/ieee1394/nodemgr.c: In function `nodemgr_update_ud_names':
> >drivers/ieee1394/nodemgr.c:471: error: structure has no member named `name'
> 
> I got a similar error starting with last night's bk pull:
> 
> drivers/pnp/core.c: In function `pnp_register_protocol':
> drivers/pnp/core.c:72: structure has no member named `name'

Hm, I thought the pnp layer had already been fixed up.

Adam?

thanks,

greg k-h
