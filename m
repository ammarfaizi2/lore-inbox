Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274424AbRJQDPP>; Tue, 16 Oct 2001 23:15:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274426AbRJQDPE>; Tue, 16 Oct 2001 23:15:04 -0400
Received: from sushi.toad.net ([162.33.130.105]:34008 "EHLO sushi.toad.net")
	by vger.kernel.org with ESMTP id <S274424AbRJQDO4>;
	Tue, 16 Oct 2001 23:14:56 -0400
Subject: Re: [PATCH] PnP BIOS -- bugfix; update devlist on setpnp
From: Thomas Hood <jdthood@mail.com>
To: linux-kernel@vger.kernel.org
Cc: sduchene@mindspring.com
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.15 (Preview Release)
Date: 16 Oct 2001 23:14:44 -0400
Message-Id: <1003288485.14282.100.camel@thanatos>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Thomas:
> Just to let you know I still have the same problem with a resource
> conflict between the PnPBIOS code and the i2c/lm_sensors stuff at
> 1040 with this latest patch.

Yep, I know.  I haven't addressed this bug in any of the
patches I've submitted to l-k.  I'd like to fix it, but
I don't know how yet: I have only a partial understanding of
how resource allocation works.

Thanks for testing yesterday's PnP BIOS patch.

--
Thomas

