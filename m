Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277001AbRJCVqi>; Wed, 3 Oct 2001 17:46:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277000AbRJCVq2>; Wed, 3 Oct 2001 17:46:28 -0400
Received: from sushi.toad.net ([162.33.130.105]:27546 "EHLO sushi.toad.net")
	by vger.kernel.org with ESMTP id <S276998AbRJCVqN>;
	Wed, 3 Oct 2001 17:46:13 -0400
Subject: Re: Stelian Pop <stelian.pop@fr.alcove.com>
To: linux-kernel@vger.kernel.org
Date: Wed, 3 Oct 2001 17:46:09 -0400 (EDT)
X-Mailer: ELM [version 2.4ME+ PL73 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Message-Id: <20011003214609.DCB3F10E5@thanatos.toad.net>
From: jdthood@home.dhs.org (Thomas Hood)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the info.

> Again: both laptops oops with 2.4.9-ac16 when PnPBIOS is enabled, both 
> work fine with 2.4.10-ac4 even with PnPBIOS enabled.

What happens if you read from the numerically named files in /proc/bus/pnp?
(Do sync;sync;sync before trying this.)

-- 
Thomas Hood
(Don't reply to the From: address but to jdthood_AT_yahoo.co.uk)
