Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261265AbUK0Q6e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261265AbUK0Q6e (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 11:58:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261266AbUK0Q6d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Nov 2004 11:58:33 -0500
Received: from inx.pm.waw.pl ([195.116.170.20]:21121 "EHLO inx.pm.waw.pl")
	by vger.kernel.org with ESMTP id S261263AbUK0Q6b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Nov 2004 11:58:31 -0500
To: Ferenci Daniel <Daniel.Ferenci@siemens.com>
Cc: linux-kernel@vger.kernel.org, linux-x25@vger.kernel.org
Subject: Re: x25 forward
References: <41A5B137.6070405@siemens.com>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Sat, 27 Nov 2004 17:24:57 +0100
In-Reply-To: <41A5B137.6070405@siemens.com> (Ferenci Daniel's message of
 "Thu, 25 Nov 2004 11:17:27 +0100")
Message-ID: <m3wtw745uu.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ferenci Daniel <Daniel.Ferenci@siemens.com> writes:

> +++ linux-2.4.25.intel/net/x25/af_x25.c	Sat Nov 13 09:30:12 2004
> @@ -26,6 +26,7 @@
>   *	2000-10-02	Henner Eisen	Made x25_kick() single threaded per socket.
>   *	2000-10-27	Henner Eisen    MSG_DONTWAIT for fragment allocation.
>   *	2000-11-14	Henner Eisen    Closing datalink from NETDEV_GOING_DOWN
> + *	2000-11-12	Daniel Ferenci	Forward capability added
        ^^^^
Some time warp machine, eh? :-)
-- 
Krzysztof Halasa
